class Yelp::Search < Yelp
  PATH = '/v2/search'

  ACCEPTED_PARAMS = %w(
    term
    limit
    location
    ll
    cll
    offset
    sort
    category_filter
    radius_filter
    claimed_filter
  )

  def find(params)
    if !params.is_a?(Hash)
      raise "You must provide a hash to perform a search."
    end

    invalid_param = params.keys.select { |k| !ACCEPTED_PARAMS.member?(k.to_s) }.first
    raise ApiError, "Invalid parameter: #{invalid_param}" if invalid_param

    response_body = @connection.get(Yelp.build_query(PATH, params)).body
    return JSON.parse(response_body)
  end
end
