module Sunspot
  module Search
    class AbstractSearch
      # Fix utf-8 trouble in search with solr, tomcat and sunspot_solr by Klaus Magalhaes
      def execute
        reset
        params = @query.to_params
        save_ferris = {:data => params, :headers => {'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8'}}
        @solr_result = @connection.post "#{request_handler}", save_ferris
        self
      end
    end
  end
end