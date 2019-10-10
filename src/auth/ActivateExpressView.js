import {
  parse as parseQueryString,
  decodeQueryParams
} from 'serialize-query-params';
import parseUrl from 'parseurl';

import { SSRCallback } from '../server/utils/ssr';
import { executeMutation } from '../common/utils/urql';
import { QueryParams, ActivateMutation } from './ActivateCommon';

export default SSRCallback( async (req, res, next, client) => { 

    const { token, uid } = decodeQueryParams(QueryParams, parseQueryString(parseUrl(req).search));

    const mutationresult = await executeMutation(client, ActivateMutation, { token: token, uid: uid });

    if (mutationresult.data && mutationresult.data.activate.success) {
      res.locals.serverContextValue =  true;
    }
    else {
      res.locals.serverContextValue =  false;
    }
    return next();
  }
)
