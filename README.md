# jquery.fakeReplace

A jQuery plugin to "replace" an html element but keep its original text for select and copy.

## Install

```bash
bower install jquery.fakeReplace
```

## Usage

```javascript
$('#myelement').fakeReplace(function(src){
  src.replace(/the/gi, 'DA')})
```

## Development

```bash
git clone git@github.com:akatov/jquery.fakeReplace.git
cd jquery.fakeReplace
npm install
bower install
grunt build
```
