import React from 'react';
import serialize from 'serialize-javascript';

const ServerStateContextComponent = ({ data, ...props }) => {
  return (
    <script
      type="text/javascript"
      // eslint-disable-next-line react/no-danger
      dangerouslySetInnerHTML={{
        __html: `window.__SERVER_STATE_CONTEXT__=${serialize(data)};`,
      }}
      {...props}
    />
  );
};

export default ServerStateContextComponent;