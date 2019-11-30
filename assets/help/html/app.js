window.CRISP_RUNTIME_CONFIG = {
  lock_maximized: true,
  lock_full_view: true,
};
console.log(1)
// window.CRISP_TOKEN_ID = '5c586283-3461-47c0-96be-f52787a596fb';
window.CRISP_WEBSITE_ID = 'af0c6ade-a9f0-471f-9ff5-af209519a512';

window.$crisp = [];

function initialize() {
  var _document = document;
  var _script = _document.createElement('script');

  _script.src = 'https://client.crisp.chat/l.js';
  _script.async = 1;
  _document.getElementsByTagName('head')[0].appendChild(_script);
}

initialize()