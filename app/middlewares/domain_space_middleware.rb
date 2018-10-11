class DomainSpaceMiddleware < Struct.new(:app, :options)
  def call(env)
    host = env["SERVER_NAME"]

    # adds to env:
    #
    # 'qkspace.area' => {
    #   :kind => :private or :public,
    #   :public_type => :subdomain or :domain,
    #   :public_name => value or slug/domain,
    #   :private_domain => qkspace.com or qkspace.localhost
    # }

    result = parse_host(host)

    if result
      env['qkspace.area'] = result
      app.call(env)
    else
      Rails.logger.error("Can't parse host #{host.inspect}, returning 404")
      [404, {}, []]
    end
  end

  private

  def parse_host(host)
    own_domains = options[:own_domains]

    return {kind: :private, private_domain: "localhost"} if host == "localhost"
    return {kind: :private, private_domain: host} if own_domains.include?(host)

    parts = host.split('.')

    return nil if parts.length < 2

    if parts.length == 2 && parts.last == "localhost"
      return {
        kind: :public,
        public_type: :subdomain,
        public_name: parts.first,
        private_domain: "localhost"
      }
    end

    domain =
      own_domains.find do |d|
        host =~ /\.#{d}\Z/
      end

    # If it's not our domain, it's someone else's
    unless domain
      return {
        kind: :public,
        public_type: :domain,
        public_name: host,
        private_domain: private_domain
      }
    end

    # Otherwise, it's ours
    return {kind: :public, public_type: :subdomain, public_name: parts[0], private_domain: private_domain}
  end

  def private_domain
    Rails.env.development? ? "qkspace.localhost" : "qkspace.com"
  end
end
