target urls:
1. Writing JSON APIs with Yesod
   https://pbrisbin.com/posts/writing_json_apis_with_yesod/

   posts
   - post a new post:
     % curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"title" : "this is a title.", "content" : "this is a content."}' --noproxy "*" http://localhost:3000/posts
   - get all posts:
     % curl -v -H "Accept: application/json" --noproxy "*" http://localhost:3000/posts
   - get one post with ID:
     % curl -v -H "Accept: application/json" --noproxy "*" http://localhost:3000/posts/1
   - update a post with ID:
     % curl -v -H "Accept: application/json" -H "Content-type: application/json" -X PUT -d '{"title" : "updated title.", "content" : "updated content."}' --noproxy "*" http://localhost:3000/posts/1
   - delete a post with ID:
     % curl -v -H "Accept: application/json" -X DELETE --noproxy "*" http://localhost:3000/posts/1
   - post multiple posts at once !
     % curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '[{"title" : "title-x.", "content" : "this is a x content."}, {"title" : "title-x.", "content" : "this is a x content."},{"title" : "title-x.", "content" : "this is a x content."}]' --noproxy "*" http://localhost:3000/mpost

   comments
   - post a new comment.
     % curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"content" : "this is a comment."}' --noproxy "*" http://localhost:3000/posts/2/comments
     MEMO: "post" field is not needed in JSON data because it is written in URL.
     NOTE: post new comment with not existing post id should have failed...
   - get all comments
     % curl -v -H "Accept: application/json" --noproxy "*" http://localhost:3000/posts/2/comments
   - get a comment with comment id.
     % curl -v -H "Accept: application/json" --noproxy "*" http://localhost:3000/posts/2/comments/1
   - update a comment with comment id.
     % curl -v -H "Accept: application/json" -H "Content-type: application/json" -X PUT -d '{"content" : "this is a updated comment."}' --noproxy "*" http://localhost:3000/posts/2/comments/1
     MEMO: "post" field is not needed in JSON data because it is written in URL.
   - delete a comment with ID:
     % curl -v -H "Accept: application/json" -X DELETE --noproxy "*" http://localhost:3000/posts/2/comments/1


2. RESTful Content
   http://www.yesodweb.com/book/restful-content
3. JSON Web Service
   http://www.yesodweb.com/book/json-web-service
4. Interfacing with RESTful JSON APIs
   https://www.schoolofhaskell.com/school/to-infinity-and-beyond/competition-winners/interfacing-with-restful-json-apis

