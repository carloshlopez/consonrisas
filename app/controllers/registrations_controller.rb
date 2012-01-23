class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:omniauth] = nil unless @member.new_record?

    if params[:isFacilitator] and params[:isFacilitator] == "true"
      session[:isFacilitator] = true
    end

    if params[:isFundation] and params[:isFundation] == "true"
      fund = Fundation.new(params[:fundation])
      if fund.save
        FundationAdmin.create(:member_id =>@member.id, :fundation_id => fund.id, :active=>true)
      end
      puts "************** Creando la Fundation #{params[:fundation]}"
      session[:isFundation] = true
      session[:fundation] = fund.id
    end    
  
    if params[:isProvider] and params[:isProvider] == "true"
      prov = Provider.new(params[:provider])
      if prov.save
        ProviderAdmin.create(:member_id =>@member.id, :provider_id => prov.id, :active=>true)
      end
      puts "************** Creando el Provider #{params[:provider]}"      
      session[:isProvider] = true
      session[:provider] = prov.id
    end    
  
  end
  
  private
  
  def build_resource(*args)
    super
    if session[:omniauth]
      @member.apply_omniauth(session[:omniauth])
      @member.valid?
    end
  end
end
