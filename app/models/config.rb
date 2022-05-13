class Config
    @trial_data = { 
                "oo_address" => "https://onlinedocs.onlyoffice.com/", 
                "jwtHeader" => "AuthorizationJWT",
                "jwtsecret" => "sn2puSUF7muF5Jas", 
            }
    @config = nil

    class << self
        def init
            if Setting.plugin_onlyoffice_redmine["editor_demo"].eql?("on")
                path = Rails.root.join('plugins', 'onlyoffice_redmine', 'config', 'config.yaml')
                if File.exists?(path) && 
                    @config = JSON.parse(File.open(path, 'r'){ |file| file.read })
                    if @config["data"] == "none"
                        create_trial_data
                        @config = JSON.parse(File.open(path, 'r'){ |file| file.read })
                    end
                end
            end
        end

        def get_config(key, for_settings = false)
            init
            get = (Setting.plugin_onlyoffice_redmine["editor_demo"].eql?("on") && istrial) || for_settings ? @trial_data[key] : Setting.plugin_onlyoffice_redmine[key]
            return key.eql?("oo_address") ? check_valid_url(get) : get
        end

        def istrial
            init
            if !@config.nil?
                if Time.now < Time.parse(@config["data"]) + (@config['trial']*24*60*60)
                    return true
                else
                    return false
                end
            end
            return false
        end

        def check_valid_url(url)
            url = url.present? ? url : ""
            check_url = url[-1].eql?("/") ? url : url + "/"
            check_url = check_url.eql?("/") ? "" : check_url
            return check_url
        end

        def create_trial_data
            path = Rails.root.join('plugins', 'onlyoffice_redmine', 'config', 'config.yaml')
            data = { 
                "data" => Time.now, 
                "trial" => 30,
            }
            File.open(path, 'w'){ |file| file.write data.to_json }
        end
    end
end