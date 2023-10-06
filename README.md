# Gemstash on Dokku

## Setup

### 1. Create a new Dokku app

```shell
dokku apps:create gemstash
```

Example with postgres database:

```shell
dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres
dokku postgres:create gemstash
dokku postgres:link gemstash gemstash
```

### 2. Create persisted storage

```shell
dokku storage:ensure-directory gemstash
dokku storage:mount gemstash /var/lib/dokku/data/storage/gemstash:/data
```

### 3. Set domain

```shell
dokku domains:set gemstash gems.your-domain.com
```

### 4. Clone this repo

```shell
git clone https://github.com/CiTroNaK/gemstash-on-dokku.git
```

### 5. Deploy

```shell
git remote add dokku dokku@<dokku-host>:gemstash
git push dokku main:master
```

## Optional steps

### 1. Set SSL with Let's Encrypt

```shell
dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
dokku letsencrypt:set gemstash email you@example.com
dokku letsencrypt:enable gemstash
```

### 2. Secure the instance with Basic Auth

```shell
dokku plugin:install https://github.com/dokku/dokku-http-auth.git
cd /home/; chmod +x dokku
dokku http-auth:enable gemstash username password
```

### 3. Add private gems credentials

#### On Dokku

Example for storing Sidekiq Pro/Ent credentials:

```shell
dokku config:set gemstash GEMSTASH_GEMS__CONTRIBSYS__COM=XXX:YYY
```

#### In your app

Set credentials for your Gemstash instance (you should if you want to use it for private gems), e.g. based on the previous step:

```shell
bundle config YOUR_GEMSTASH_DOMAIN username:password
```

Usage in `Gemfile`:

```ruby
source "https://rubygems.org"

ruby "3.2.2"

source "https://<YOUR_GEMSTASH_DOMAIN>/upstream/gems.contribsys.com" do
  gem "sidekiq-pro"
end
```
