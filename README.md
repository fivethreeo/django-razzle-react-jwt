# React with server-side rendering and django api on docker

## Features

* Building using [razzle]
* Runtime configuration in server and client
* Webpack hot module reloading in client and server
* Server-side rendering
* Suspense server side using [react-ssr-prepass]
* Server-side handlers for graceful degradation of registration/ activation/ login/ social views.  
* Code splitting using [@loadable/component]
* Babel 7 with fragments
* React 16.8.6 with hooks
* Using [formik] for forms with [blueprintjs]
* Registration / activation/ social login and authentication using social-auth-app-django, JWT and graphene
* Using [træfik] for routing requests and ssl.

## How to use

Download the example [or clone](https://github.com/fivethreeo/react-ssr-django-jwt-docker.git):

```bash
curl https://codeload.github.com/fivethreeo/react-ssr-django-jwt-docker/tar.gz/master | tar -xz react-ssr-django-jwt-docker-master
cd react-ssr-django-jwt-docker-master
```

### To run using docker

Build images:

```bash
sudo docker-compose -f docker-compose.dev.yml build
```

Run database migrations:

```bash
touch db.sqlite3
sudo docker-compose -f docker-compose.dev.yml run djangoapi python manage.py migrate
```

Run all services (traefik, djangoapi, reactapp):

```bash
sudo docker-compose -f docker-compose.dev.yml up
```

### To test registration email

```bash
export EMAIL_URL=smtp://username:password@localhost:25
sudo -E docker-compose -f docker-compose.dev.yml up
```

### To test social auth

Go to [https://github.com/settings/developers](https://github.com/settings/developers) and click `New Oauth App`.

Set `Authorization callback URL` to `https://localhost/social/github/complete`.

```bash
export SOCIAL_AUTH_GITHUB_KEY="5137xfvkhv44468bca82e88"
export SOCIAL_AUTH_GITHUB_SECRET="23b3yfifvveeeyhvb0c6ce80bb"
sudo -E docker-compose -f docker-compose.dev.yml up
```

### To add other social backends:

Add more backends to `AUTHENTICATION_BACKENDS` in `djangoapi/settings.py`. 

Add extra `SOCIAL_AUTH_[BACKEND]_[SECRET|KEY]` settings in `djangoapi/settings.py`. 

See [https://python-social-auth.readthedocs.io/en/latest/configuration/django.html#authentication-backends](https://python-social-auth.readthedocs.io/en/latest/configuration/django.html#authentication-backends)

### Try it out

Go to [https://localhost](https://localhost).

To remove https warnings add `certs/localhost_https_ca.pem` to authorities in your browser.

To make your own certs:

```bash
cd certs
rm localhost_https*
bash makecert.sh --dn-c "US" --dn-st "TX" --dn-l "Houston" \
  --dn-o "Your organization" --dn-ou "Your department" \
  --dn-email "your@email.com" \
  --common-name "localhost" --dns "localhost" --ip "127.0.0.1" --https
```
## Teasers

![index](https://raw.githubusercontent.com/fivethreeo/react-ssr-django-jwt-docker/master/index.png)

![login](https://raw.githubusercontent.com/fivethreeo/react-ssr-django-jwt-docker/master/login.png)

![todo](https://raw.githubusercontent.com/fivethreeo/react-ssr-django-jwt-docker/master/todo.png)

## Ideas behind the example

* [razzle][razzle]

  [razzle]: <https://github.com/jaredpalmer/razzle>
  [@loadable/component]: <https://github.com/smooth-code/loadable-components#readme>
  [react-ssr-prepass]: <https://github.com/FormidableLabs/react-ssr-prepass>
  [træfik]: <https://traefik.io/>
  [formik]: <https://github.com/jaredpalmer/formik>
  [blueprintjs]: <https://blueprintjs.com/>
