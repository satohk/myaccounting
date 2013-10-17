class Setting < ActiveRecord::Base
  attr_accessible :user_id, :key, :value


  def Setting.settings_json_for_user(user_id)
    settings = Setting.where(:user_id => user_id)
    
    settings_hash = {}
    settings.each do |val|
      settings_hash[val.key] = val.value
    end
    return settings_hash.to_json.html_safe
  end

  def Setting.import_hash(hash, user_id)
    ActiveRecord::Base.transaction do
      hash.each do |key, val|
        settings = Setting.where(:user_id => user_id, :key => key)
        if settings.length == 0
          setting = Setting.create!(:user_id => user_id, :key => key, :value => val)
        else
          setting = settings.first
          res = setting.update_attributes(:user_id => user_id, :key => key, :value => val)
        end
      end
    end
    return true
  rescue => e
    logger.debug e
    return nil
  end
end
