require 'resolv'

class ProjectDomainService
  attr_reader :project

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

  def initialize(area_private_domain:, project:)
    @area_private_domain = area_private_domain
    @project = project
  end

  def destroy
    @project.update_attribute(:domain, nil)
  end

  def domain_set?
    @project.domain_was.present?
  end

  def humanized_domain
    SimpleIDN.to_unicode(@project.domain)
  end

  def update(domain)
    if domain.empty?
      @project.errors.add(:domain, :empty)
      return false
    end

    @project.domain = SimpleIDN.to_ascii(domain.downcase)
    return true unless @project.domain_changed?
    return false unless @project.valid?

    cname = self.class.get_cname(@project.domain)

    if cname == correct_cname
      Project.transaction do
        Project.where(domain: @project.domain).update_all(domain: nil)
        @project.save || raise(ActiveRecord::Rollback)
      end
    else
      @project.errors.add(:domain, :not_confirmed)
      false
    end
  end

  def correct_cname
    "#{@project.id}.#{@area_private_domain}"
  end
end
