module Web.View.Sessions.Home where
import Web.View.Prelude

data HomeView = HomeView {listings :: [Listing]}

instance View HomeView ViewContext where
    html HomeView { .. } = do 
        case currentUserOrNothing of 
            Just currentUser -> [hsx|
            <div class="row">
                <div class="col">
                    <h1>Listings</h1>
                        <nav>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item active"><a href={UsersAction}>Users</a></li>
                                <li class="breadcrumb-item active"><a href={ShowUserAction (get #id currentUser )}>View my listings</a></li>
                            </ol>
                        </nav>
                </div>
            </div>
            <hr/>
            <div class="card-columns">
                {forM_ listings renderListing}
            </div>
            |]
            Nothing -> [hsx|
            <div class="row">
                <div class="col">
                    <h1>Listings</h1>
                </div>
            </div>
            <hr/>
            <div class="card-columns">
                {forM_ listings renderListing}
            </div>
            |]


renderListing listing = 
    [hsx|
    <div class="card">
        <img src="https://www.amityinternational.com/wp-content/uploads/2019/02/product-placeholder.jpg" class="card-img-top" alt="...">
        <div class="card-body">
            <h5 class="card-title">{get #title listing}</h5>
            <p class="card-text">{get #description listing}</p>
        </div>
        <div class="card-footer">
            <a href={ShowListingAction (get #id listing)} class="text-muted card-link">Show</a>
            <a href={EditListingAction (get #id listing)} class="text-muted card-link">Edit</a>
            <a href={DeleteListingAction (get #id listing)} class="js-delete text-muted card-link">Delete</a>
            <small class="text-muted float-right">{get #createdAt listing |> timeAgo}</small>
        </div>
    </div>
|]