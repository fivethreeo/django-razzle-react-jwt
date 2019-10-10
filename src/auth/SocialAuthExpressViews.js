import { SSRCallback } from '../server/utils/ssr';
import { executeMutation } from '../common/utils/urql';
import { SocialAuthMutation, SocialAuthCompleteMutation } from './SocialAuthCommon';
import serialize from 'serialize-javascript';

import config from '../config';


export const SocialAuthExpressView = SSRCallback( async (req, res, next, client) => {
  
  const state = {};

  const result = await executeMutation(client, SocialAuthMutation, {
    provider: req.params.provider,
    redirectUri: config('APP_URL') + '/social/' + req.params.provider + '/complete'
  });

  if (result.error && result.error.graphQLErrors) {
    state['error'] = result.error.graphQLErrors[0].message;
    res.locals.serverContextValue = state;
    return next();
  }
  else if (result.data && result.data.socialAuth) {
    if (result.data.socialAuth.result.__typename === 'Redirect') {
      return res.redirect(result.data.socialAuth.result.url);
    }
  }
  else {
    return next();
  }

})

export const SocialAuthCompleteExpressView = SSRCallback( async (req, res, next, client) => {
  
  const state = {};

  const requestData = serialize(req.query);

  const result = await executeMutation(client, SocialAuthCompleteMutation, {
    provider: req.params.provider,
    requestData: requestData,
    redirectUri: config('APP_URL') + '/social/' + req.params.provider + '/complete'
  });

  if (result.error && result.error.graphQLErrors) {
    state['error'] = result.error.graphQLErrors[0].message;
    res.locals.serverContextValue = state;
    return next();
  }
  else if (result.data && result.data.socialAuthComplete) {
    if (result.data.socialAuthComplete.result.__typename === 'Redirect') {
      return res.redirect(result.data.socialAuthComplete.result.url);
    }
    if (result.data.socialAuthComplete.result.__typename === 'JWT') {
      req.universalCookies.set('authToken', result.data.socialAuthComplete.result.token, {
        path: '/',
        expires: new Date(new Date().getTime()+1000*60*60*24),
        maxAge: 60*60*24,
        domain: config('COOKIE_HOST'),
        secure: config('COOKIE_SECURE'),
        httpOnly: false,
        sameSite: true
      })
      return res.redirect(301, '/');
    }
  }
  else {
    return next();
  }

})