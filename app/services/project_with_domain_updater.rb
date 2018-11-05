require 'resolv'

class ProjectWithDomainUpdater
  def self.get_cname(domain)
    Rails.logger.info("Getting CNAME for #{domain}")

    begin
      r =
        Resolv::DNS.open do |dns|
          dns.getresource(domain, Resolv::DNS::Resource::IN::CNAME)
        end
      r = r.name.to_s
      Rails.logger.info("CNAME = #{r.inspect}")
      r
    rescue Resolv::ResolvError => e
      Rails.logger.info("Error: #{e}")
      nil
    end
  end

  def initialize(request:, project:)
    @request = request
    @project = project
  end

  def update(domain)
    return if @project.new_record?
    if domain.empty?
      return @project.update_attribute(:domain, nil)
    end

    @project.domain = domain
    return true unless @project.domain_changed?
    return false unless @project.valid?

    cname = self.class.get_cname(@project.domain)

    if cname && cname == correct_cname
      @project.save
    else
      @project.errors.add(:domain, :not_confirmed)
      false
    end
  end

  def correct_cname
    "#{@project.id}.#{@request.env['qkspace.area'][:private_domain]}"
  end
end
