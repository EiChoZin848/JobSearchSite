module CurrentAppliedJob
    private
    def set_t_appliedjob
        @t_appliedjob = TAppliedJobs.find(session[:t_appliedjob_id])
    rescue ActiveRecord::RecordNotFound
        @t_appliedjob = TAppliedJobs.create
        session[:t_appliedjob_id] = @t_appliedjob.id
    end
end