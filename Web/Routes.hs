module Web.Routes where
import IHP.RouterPrelude
import Generated.Types
import Web.Types

instance AutoRoute SessionsController

-- Generator Marker
instance AutoRoute PostsController
type instance ModelControllerMap WebApplication Post = PostsController

instance AutoRoute CommentsController
type instance ModelControllerMap WebApplication Comment = CommentsController

instance AutoRoute UsersController
type instance ModelControllerMap WebApplication User = UsersController

instance AutoRoute ListingsController
type instance ModelControllerMap WebApplication Listing = ListingsController

instance AutoRoute SearchController where
    parseArgument = parseTextArgument

