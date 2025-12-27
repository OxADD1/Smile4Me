func getJoke() async throws -> Joke {
   // let url = "https://v2.jokeapi.dev/joke/Any?blacklistFlags=nsfw,religious,political,racist,sexist,explicit"
   // let url = "https://v2.jokeapi.dev/joke/\(Category.Pun)?blacklistFlags=nsfw,religious,political,racist,sexist,explicit"
   // let url = "https://v2.jokeapi.dev/joke/Any?lang=\(Language.cs)&blacklistFlags=nsfw,religious,political,racist,sexist,explicit"
    let url = "https://v2.jokeapi.dev/joke/\(Category.Misc)?lang=\(Language.fr)&blacklistFlags=nsfw,religious,political,racist,sexist,explicit"
    let apiService = APIService(urlString: url)
    do {
        return try await apiService.getJSON()
    } catch {
        throw error
    }
}