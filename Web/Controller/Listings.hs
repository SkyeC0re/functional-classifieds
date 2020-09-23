module Web.Controller.Listings where

import Web.Controller.Prelude
import Web.View.Listings.Index
import Web.View.Listings.New
import Web.View.Listings.Edit
import Web.View.Listings.Show

instance Controller ListingsController where
    action ListingsAction = do
        listings <- query @Listing |> fetch
        render IndexView { .. }

    action NewListingAction = do
        ensureIsUser
        let userId = (get #id currentUser)
        let listing = newRecord
                |> set #userId userId
        render NewView { .. }

    action ShowListingAction { listingId } = do
        listing <- fetch listingId
        render ShowView { .. }

    action EditListingAction { listingId } = do
        listing <- fetch listingId
        render EditView { .. }

    action UpdateListingAction { listingId } = do
        listing <- fetch listingId
        listing
            |> buildListing
            |> ifValid \case
                Left listing -> render EditView { .. }
                Right listing -> do
                    listing <- listing |> updateRecord
                    setSuccessMessage "Listing updated"
                    redirectTo EditListingAction { .. }

    action CreateListingAction = do
        let listing = newRecord @Listing
        listing
            |> buildListing
            |> ifValid \case
                Left listing -> render NewView { .. } 
                Right listing -> do
                    listing <- listing |> createRecord
                    setSuccessMessage "Listing created"
                    redirectTo ListingsAction

    action DeleteListingAction { listingId } = do
        listing <- fetch listingId
        deleteRecord listing
        setSuccessMessage "Listing deleted"
        redirectTo ListingsAction

buildListing listing = listing
    |> fill @["userId","title","description","price","createdAt"]