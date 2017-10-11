# PartialKs

A library to use kitchen-sync to sync a subset of your database

# Usage

So how does it work ?


```
PartialKs::KitchenSync.new(manual_configuration).run! do |tables_to_filter, tables|
  puts tables_to_filter.inspect
  puts tables.inspect
end
```

You can specify manual configurations if needed.

```
manual_configuration = [
  [User, nil, -> { User.where(:id => [1]) }],     # specify a subset of users. as users have no parent, specify `nil`
  [BlogPost, User]                         # filter blog_posts by User
]
```

NB: The first use case for this gem is to be run in conjuction with [Kitchen Sync](https://github.com/willbryant/kitchen_sync). On OSX, one can install Kitchen Sync using `brew install kitchen-sync`

# Public API

It currently consists of :

  - PartialKs::KitchenSync


# Not supported

Things that are not supported in this version.

* Polymorphic relationships
* Tables with STI


