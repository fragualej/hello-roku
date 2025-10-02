sub init()
    m.baseUrl = m.constants.api.TMDB_API_BASE_URL
    m.token = m.constants.api.TMDB_TOKEN
    m.httpTask = createObject("roSGNode", "httpTask")
    m.httpTask.control = "RUN"
end sub

function getGenres(request as object)
    url = substitute("{0}/genre/movie/list", m.baseUrl)
    request.addReplace("url", url)
    request.addReplace("model", "genres")
    enqueue(request)
end function

function getMoviesByGenre(request as object)
    url = substitute("{0}/discover/movie?include_adult=false&include_video=false&language=en-US&page={1}&sort_by=popularity.desc&with_genres={2}", m.baseUrl, request.pageIndex.toStr(), request.genreId.toStr())
    request.addReplace("url", url)
    request.addReplace("model", "movies")
    enqueue(request)
end function

sub enqueue(request as object)
    headers = {
        "Authorization": "Bearer " + m.token,
        "accept": "application/json",
    }
    request.addReplace("headers", headers)
    m.httpTask.request = request
end sub