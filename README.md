# Gemstash on Dokku

## Setup

### 1. Create a new Dokku app

```bash
dokku apps:create gemstash
```

Example with postgres database:

```bash
dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres
dokku postgres:create gemstash
dokku postgres:link gemstash gemstash
```

### 2. Create persisted storage

```bash
dokku storage:ensure-directory gemstash
dokku storage:mount gemstash /var/lib/dokku/data/storage/gemstash:/data
```

### 3. Set domain

```bash
dokku domains:set gemstash gems.your-domain.com
```

### 4. Clone this repo

```bash
git clone https://github.com/CiTroNaK/gemstash-on-dokku.git
```

### 5. Deploy

```bash
git remote add dokku dokku@<dokku-host>:gemstash
git push dokku main:master
```

### 6. Set SSL

You can add Let's Encrypt certificate.

```bash
dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
dokku letsencrypt:set gemstash email you@example.com
dokku letsencrypt:enable gemstash
```
