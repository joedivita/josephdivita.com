S3_BUCKET = ''

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, '/images'

activate :directory_indexes

activate :blog do |blog|
  blog.prefix        = 'blog'
  blog.permalink     = "{title}"
  blog.paginate      = true
  blog.per_page      = 10
  blog.layout        = 'post'
  blog.tag_template  = 'blog/tag'
end

# Methods defined in the helpers block are available in templates
helpers do
  def format_date(date)
    date.strftime("%B %e, %Y")
  end
end

# Development Specific Config
configure :development do
  activate :dotenv, env: '.env'
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  activate :minify_html, :remove_http_protocol => false, :remove_https_protocol => false

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Serve gzipped files
  activate :gzip

  # Set proper dot env file
  activate :dotenv, env: '.env.production'
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = S3_BUCKET
  s3_sync.delete                     = true
  s3_sync.prefer_gzip                = true
  # s3_sync.after_build                = false # We do not chain after the build step by default.
  # s3_sync.path_style                 = true
  # s3_sync.reduced_redundancy_storage = false
  # s3_sync.acl                        = 'public-read'
  # s3_sync.encryption                 = false
  # s3_sync.prefix                     = ''
  # s3_sync.version_bucket             = false
end

activate :s3_redirect do |config|
  config.bucket = S3_BUCKET
end
