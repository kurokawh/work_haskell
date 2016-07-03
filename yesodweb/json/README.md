target urls:
1. Writing JSON APIs with Yesod
   https://pbrisbin.com/posts/writing_json_apis_with_yesod/

   - post a new post:
   % curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"title" : "this is a title.", "content" : "this is a content."}' http://localhost:3000/posts
   - get all posts:
   % curl -v -H "Accept: application/json" http://localhost:3000/posts
   - get one post with ID:
   % curl -v -H "Accept: application/json" http://localhost:3000/posts/1


2. RESTful Content
   http://www.yesodweb.com/book/restful-content
3. JSON Web Service
   http://www.yesodweb.com/book/json-web-service
4. Interfacing with RESTful JSON APIs
   https://www.schoolofhaskell.com/school/to-infinity-and-beyond/competition-winners/interfacing-with-restful-json-apis
