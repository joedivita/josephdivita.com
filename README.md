## Running Locally

1. Run bundler & start the middleman server:

```
$ bundle install
$ middleman server
```

## Deploying

1. Commit all changes and make sure directory is clean
2. Run the following:

```
$ rm -rf build
$ middleman build
$ middleman s3_sync
```

Log into the AWS console and create an invalidation for all directories in the homepage Cloud Front distribution (if using Cloud Front)

## Adding New Blog Articles

1.  Add the new article in the /blog directory as {date}-{title}.markdown
2.  Add a redirect in config.rb (optional):

```
redirect '/blog/{title}', '/blog/{title}.html'
```

4. rm -rf build
5. middleman build
6. middleman s3_sync
7. middleman s3_redirect
8. Create a new Cloud Front invalidation (if applicable)

## TODO

- Automatically trigger an invalidation for the homepage Cloud Front Distribution on deploy.
