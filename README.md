# MatBucketList

[![Code Climate](https://codeclimate.com/github/andela-oojewale/matbucketlist/badges/gpa.svg)](https://codeclimate.com/github/andela-oojewale/matbucketlist)

[![Test Coverage](https://codeclimate.com/github/andela-oojewale/matbucketlist/badges/coverage.svg)](https://codeclimate.com/github/andela-oojewale/matbucketlist/coverage)


The Bucket List is here!

This API allows a user to create an account and create as many bucket lists as they want. Everyone has one thing that they want to do-  where they want to be, things they want to buy, people they want to meet et al- in their lifetime.

This API is created to meet just that need.

The endpoints that the API provides are listed below:

* POST /users/create -  Creates a new user.
* POST /auth/login - Logs in a user
* GET /auth/logout - Logs a user out
* POST /bucketlists/ - Creates a new bucket list
* GET /bucketlists/ - Lists all the created bucket lists
* GET /bucketlists/<id> - Gets single bucket list
* GET /bucketlists?q=name - Gets bucket list with the name specified
* GET /bucketlists?page=2&limit=23 - Paginates your bucket lists.
* PUT /bucketlists/<id> - Updates this bucket list
* DELETE /bucketlists/<id> - Deletes this single bucket list
* POST /bucketlists/<id>/items/ - Creates a new item in bucket list
* PUT /bucketlists/<id>/items/<item_id> - Updates a bucket list item
* DELETE /bucketlists/<id>/items/<item_id> - Deletes an item in a bucket list

Only the new user creation and user login endpoints are accessible without being logged in. All others require the user to be logged in.

All operations of a user are only within the scope of the users' bucket list(s) and/or item(s).

## To create a user, access [POST /users/create] with the following parameters:

`username - this should be of the type string`
`password - should be string and must not be less than 8 characters`

## To login, access [POST /auth/login] with the following parameters:

`username - should be a registered username`
`password - should be a registered password`

This returns an authentication token. Which must be present as an Authorization header in all requests made until after you log out or your when it expires. It should be used in this way:

`Authorization: "aaaaaaaaaaaaaaa.bbbbbbbbbbbbbbb.ccccccccccccccc"`


## To view all bucketlists, access [GET /bucketlists/]

This shows all your bucketlists with their corresponding items, if you have any.

## To create a bucketlist, access [POST /bucketlists/] with the following parameters:

`name - name of your bucketlist`

## To get a bucketlist with a particular id, access [GET /bucketlists/id]

This fetches the bucket list with the specified id.

## To get a bucketlist with a particular id, access [GET /bucketlists?q=name]

This fetches the bucket list with the specified name.

## To get a bucketlist with a particular id, access [GET /bucketlists?page=2&limit=23]

Gets bucket lists and paginates them as stated. In this case, it lists 23 bucket lists per page.

The default number of bucket lists for pagination is 20 per page but you can specify that you want as much as 100 on a page.

## To update a bucketlist, access [PUT /bucketlists/id] with the following parameters:

`name - name of the bucket list you want to update`

## To delete a bucketlist, access [DELETE /bucketlists/id] with the following parameters:

Deletes the bucket list with the specified id and all it associated items.

## To create a bucketlist item, access [POST /bucketlists/bucketlist_id/items] with the following parameters:

`name - name of your bucketlist item`

## To update a bucketlist item, access [PUT /bucketlists/bucketlist_id/items/id] with the following parameters:

`name - name of your bucketlist item`
`status - This states whether you have achieved or done this particular item. Defaults to false. Only change to true if you want to check it as done.`


## To delete a bucketlist item, access [DELETE /bucketlists/bucketlist_id/items/id] with the following parameters:

Deletes the bucket list item with the specified id.


You can also find the documentation for this awesome API [here](http://docs.matbucketlist.apiary.io/)

Thanks.