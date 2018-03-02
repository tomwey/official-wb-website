require 'rest-client'
class GameRecharge < ActiveRecord::Base
  validates :game_id, :uid, :money, :diamond, :recharge_desc, presence: true
  
  def money_val=(val)
    self.money = (val.to_f * 100).to_i
  end
  
  def money_val
    self.money / 100.0
  end
  
  def recharge!
    resp = RestClient.get "#{SiteConfig.game_api_server}/Recharge", 
                     { :params => { :user_id => self.uid,
                                    :diamond => self.diamond
                                  } 
                     }
    result = JSON.parse(resp)
    if result['status'].to_i == 0
      self.recharged_at = Time.zone.now
      self.save!
      return '充值成功'
    else
      return result['msg']
    end
    
  end
  
end
