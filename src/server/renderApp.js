

import config from '../config';
import ClientConfig from '../config/components/ClientConfig';

import React from 'react';
import { Router, Route } from 'react-router-dom';
import { renderToString } from 'react-dom/server';
import { ChunkExtractor } from '@loadable/server';

import { createMemoryHistory } from 'history';
import { QueryParamProvider } from 'use-query-params';
import ssrPrepass from 'react-ssr-prepass';

import CookieContext from '../common/CookieContext';
import ServerStateContext from '../common/ServerStateContext';

import ServerStateContextComponent from './components/ServerStateContextComponent';
import UrqlDataComponent from './components/UrqlDataComponent';
import WebpackNonceComponent from './components/WebpackNonceComponent';

import App from '../components/App';
import getUrqlProps from './utils/urql';

import isEmpty from 'is-empty';
import path from 'path';

import {
  Provider as UrqlProvider
} from 'urql';

const renderApp = async ({ req, res, serverState = {}, ...rest }) => {

  const { urqlSSRCache, urqlClient } = isEmpty(rest) ? getUrqlProps(req, res) : rest;
  
  const history = createMemoryHistory({
    initialEntries: [req.originalUrl]
  });

  // This is the stats file generated by webpack loadable plugin
  const statsFile = path.resolve('./build/loadable-stats.json')
  // We create an extractor from the statsFile
  const extractor = new ChunkExtractor({ statsFile, entrypoints: ['client']})
  // Wrap your application using "collectChunks"
  const jsx = extractor.collectChunks(
    <ServerStateContext.Provider value={serverState}>
      <UrqlProvider value={urqlClient}>
        <CookieContext.Provider value={req.universalCookies}>
          <Router history={history} >
            <QueryParamProvider ReactRouterRoute={Route}>
              <App />
            </QueryParamProvider>
          </Router>
        </CookieContext.Provider>
      </UrqlProvider>
    </ServerStateContext.Provider>
  )

  // Suspense prepass    
  await ssrPrepass(jsx);

  const urqlData = urqlSSRCache.extractData();
    // Render your application
  const markup = renderToString(jsx)
  // You can now collect your script tags
  const scriptElements = extractor.getScriptElements({nonce: res.locals.nonce}) // or extractor.getScriptElements();
  // You can also collect your "preload/prefetch" links
  const linkElements = extractor.getLinkElements({nonce: res.locals.nonce}) // or extractor.getLinkElements();
  // And you can even collect your style tags (if you use "mini-css-extract-plugin")
  const styleElements = extractor.getStyleElements({nonce: res.locals.nonce}) // or extractor.getStyleElements();


  const html = renderToString(<html lang="">
    <head>
        <meta httpEquiv="X-UA-Compatible" content="IE=edge" />
        <meta charSet='utf-8' />
        <title>Welcome to Razzle</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        {linkElements} 
        {styleElements}
    </head>
    <body>
        <div id="root">DO_NOT_DELETE_THIS_YOU_WILL_BREAK_YOUR_APP</div>
        <ClientConfig nonce={res.locals.nonce} />
        <UrqlDataComponent data={urqlData} nonce={res.locals.nonce} />
        <ServerStateContextComponent data={serverState} nonce={res.locals.nonce} />
        <WebpackNonceComponent nonce={res.locals.nonce} />
        {scriptElements}
    </body>
  </html>);

  res.send(
    // prettier-ignore
    `<!doctype html>${html.replace('DO_NOT_DELETE_THIS_YOU_WILL_BREAK_YOUR_APP', markup)}`
  );
};

export default renderApp;