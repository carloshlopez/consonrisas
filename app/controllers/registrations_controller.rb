class RegistrationsController < Devise::RegistrationsController
  def create
    super
#    puts "*******!!!! Llegamos a registrarnos!!"
    session[:omniauth] = nil unless @member.new_record?

    if params[:isFacilitator] and params[:isFacilitator] == "true"
      session[:isFacilitator] = true
      if @member.facilitator 
        @member.facilitator.update_attributes(params[:facilitator])
        @member.facilitator.populations.clear
        @member.facilitator.populations << Population.find(params[:population_ids]) if params[:population_ids]
#        puts "************** Se modifico al Facilitador #{params[:facilitator]}"
      end
    end

    if params[:isFundation] and params[:isFundation] == "true"
      fund = Fundation.new(params[:fundation])
      if fund.save
        FundationAdmin.create(:member_id =>@member.id, :fundation_id => fund.id, :active=>true)
        puts "************** Se creo la Fundation #{params[:fundation]}"
      end
      session[:isFundation] = true
      session[:fundation] = fund.id
      puts "*************** Datos metidos en la session por registrations #{session[:isFundation]} o #{session[:fundation]}"
    end

    if params[:isProvider] and params[:isProvider] == "true"
      begin
        prov = Provider.new(params[:provider])
        if prov.save
          ProviderAdmin.create(:member_id =>@member.id, :provider_id => prov.id, :active=>true)
          puts "************** Creando el Provider #{params[:provider]}"
        else
          puts "#{prov.errors.messages}"
        end
        session[:isProvider] = true
        session[:provider] = prov.id
      rescue Exception => e
        puts "Exception {e.inspect}"
      end
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
