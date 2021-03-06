import React, { useEffect, useContext } from 'react';
import { withRouter, Link } from 'react-router-dom';
import { useQueryParams } from 'use-query-params';
import { Context as UrqlContext } from 'urql';

import useServerState from '../hooks/useServerState';
import { executeMutation } from '../common/utils/urql';

import { ActivateMutation, QueryParams } from './ActivateCommon';


const Activate = () => {
  const [{ token, uid }] = useQueryParams(QueryParams);
  const client = useContext(UrqlContext);


  const {
    state: activated, hasServerState: hasServerActivated, setState: setActivated
  } = useServerState(false);

  useEffect(() => {

    if (!hasServerActivated && typeof window !== 'undefined') {

      executeMutation(client, ActivateMutation, { token: token, uid: uid })
        .then((res)=>{

          if (res.data && res.data.success) {
            setActivated(true);
          }
          else {
            setActivated(false);
          }
          
        });
    }
  });

  let display = <p>Activation unsuccessful</p>;

  if (activated) {

    display = <>
    <p>Activation successful</p>
    <p>You can now <Link to='/login'>sign in</Link></p>
    </>;
    
  }

  return (
    <div className="col-sm-9 col-md-7 col-lg-5 mx-auto">
      { display }
    </div>);

};


export default withRouter(Activate);