'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "f3479eca8ea51dc1a499cfc0a3ce91a1",
"assets/AssetManifest.bin.json": "c8a4836d366f2c786ce504a5f6c75861",
"assets/AssetManifest.json": "2c6754123df2fc6b49d436a48566ed5f",
"assets/assets/font/Fustat-VariableFont_wght.ttf": "698b1ad5e00c0df21af8b28e7764d28f",
"assets/assets/images/cover/cover%2520(1).webp": "9d123750244412be567b06baf2402b0d",
"assets/assets/images/cover/cover%2520(10).webp": "1c20b564237b1cc40c455fbbf48051c5",
"assets/assets/images/cover/cover%2520(11).webp": "1f1a399ff29412961f6d834684eee424",
"assets/assets/images/cover/cover%2520(12).webp": "719dd77bce2b8862ea850a85aaff3b49",
"assets/assets/images/cover/cover%2520(13).webp": "72770f35617d7a0b61a8064f16cea47e",
"assets/assets/images/cover/cover%2520(14).webp": "6d01345b80d7178f4b8b4f7567c76259",
"assets/assets/images/cover/cover%2520(15).webp": "876e178239953346a7b0043e2161938d",
"assets/assets/images/cover/cover%2520(16).webp": "dd45b221c34ace07111a3aafaf75bdb8",
"assets/assets/images/cover/cover%2520(17).webp": "6aadbb36be9799b34458c3b2b1965c7a",
"assets/assets/images/cover/cover%2520(18).webp": "2f19d818403bf2b96f275192b639e0e7",
"assets/assets/images/cover/cover%2520(19).webp": "d6d5e01a6ff83e395e160e2ecf615787",
"assets/assets/images/cover/cover%2520(2).webp": "1a02c7040c415607724326766aeb00ac",
"assets/assets/images/cover/cover%2520(20).webp": "f5ae76a5ce6b6d012d25a51f197c013e",
"assets/assets/images/cover/cover%2520(21).webp": "25f272cb5dfe6d6f67fa6aed4efe1824",
"assets/assets/images/cover/cover%2520(22).webp": "062d7082713b0f18071b3a8220475bcd",
"assets/assets/images/cover/cover%2520(23).webp": "7985638ac3afa206b26fc99e44b138fb",
"assets/assets/images/cover/cover%2520(24).webp": "5870f2ed06b62e4e46de04dd8a62a4f9",
"assets/assets/images/cover/cover%2520(25).webp": "6c3966edb6ae7e25ec636e20babba5e9",
"assets/assets/images/cover/cover%2520(26).webp": "fbcb8282eeedbd8d0bc3df4f4fca4621",
"assets/assets/images/cover/cover%2520(27).webp": "fda82d4ec6da47e2fbfe3a39b5b95059",
"assets/assets/images/cover/cover%2520(28).webp": "2bfb2673e8b2ac6ebef6cb25c6eb6436",
"assets/assets/images/cover/cover%2520(3).webp": "05684d1c8b063dd14128752d5135771c",
"assets/assets/images/cover/cover%2520(4).webp": "1eb4586cbfeb3f4235fe9679232c335b",
"assets/assets/images/cover/cover%2520(5).webp": "ef4e0240e8e8cb2046a8101b9389e92b",
"assets/assets/images/cover/cover%2520(6).webp": "53ec957927020e59cae3d21366910af3",
"assets/assets/images/cover/cover%2520(7).webp": "dc458ee456613f56187cb51d410be4d6",
"assets/assets/images/cover/cover%2520(8).webp": "555aac973e161207546644ea74e415fe",
"assets/assets/images/cover/cover%2520(9).webp": "1b68be1bd6cb9c9ca439089eded0fa38",
"assets/assets/images/dance/areca_nuts/areca%2520nuts%2520(1).webp": "ef4e0240e8e8cb2046a8101b9389e92b",
"assets/assets/images/dance/areca_nuts/areca%2520nuts%2520(2).webp": "e7222883deaf281d650baf453942141d",
"assets/assets/images/dance/areca_nuts/areca%2520nuts%2520(3).webp": "53ec957927020e59cae3d21366910af3",
"assets/assets/images/dance/areca_nuts/areca%2520nuts%2520(4).webp": "dc458ee456613f56187cb51d410be4d6",
"assets/assets/images/dance/areca_nuts/areca%2520nuts%2520(5).webp": "555aac973e161207546644ea74e415fe",
"assets/assets/images/dance/my_name_is_shi/my%2520name%2520is%2520shi%2520(1).webp": "1eb4586cbfeb3f4235fe9679232c335b",
"assets/assets/images/dance/my_name_is_shi/my%2520name%2520is%2520shi%2520(2).webp": "6d01345b80d7178f4b8b4f7567c76259",
"assets/assets/images/dance/my_name_is_shi/my%2520name%2520is%2520shi%2520(3).webp": "6c3966edb6ae7e25ec636e20babba5e9",
"assets/assets/images/dance/my_name_is_shi/my%2520name%2520is%2520shi%2520(4).webp": "2bfb2673e8b2ac6ebef6cb25c6eb6436",
"assets/assets/images/dance/nightmare/nightmare%2520(1).webp": "1c20b564237b1cc40c455fbbf48051c5",
"assets/assets/images/dance/nightmare/nightmare%2520(2).webp": "72770f35617d7a0b61a8064f16cea47e",
"assets/assets/images/dance/nightmare/nightmare%2520(3).webp": "6aadbb36be9799b34458c3b2b1965c7a",
"assets/assets/images/dance/nightmare/nightmare%2520(4).webp": "fda82d4ec6da47e2fbfe3a39b5b95059",
"assets/assets/images/dance/roaming_dream/roaming%2520dream%2520(1).webp": "1f1a399ff29412961f6d834684eee424",
"assets/assets/images/dance/roaming_dream/roaming%2520dream%2520(2).webp": "876e178239953346a7b0043e2161938d",
"assets/assets/images/dance/roaming_dream/roaming%2520dream%2520(3).webp": "8b66fd92266cae69b9d3136050cf74c0",
"assets/assets/images/dance/sword_tells/sword%2520tells%2520(1).webp": "8414b02bfa4963d7ffaeda68bb1fbad1",
"assets/assets/images/dance/sword_tells/sword%2520tells%2520(2).webp": "b3efeb7bbe565b2fe52efdb928b6830a",
"assets/assets/images/dance/sword_tells/sword%2520tells%2520(3).webp": "e653bb5058033c3ec25d89fca407de1e",
"assets/assets/images/dance/sword_tells/sword%2520tells%2520(4).webp": "1b68be1bd6cb9c9ca439089eded0fa38",
"assets/assets/images/dance/sword_tells/sword%2520tells%2520(5).webp": "719dd77bce2b8862ea850a85aaff3b49",
"assets/assets/images/dance/sword_tells/sword%2520tells%2520(6).webp": "dd45b221c34ace07111a3aafaf75bdb8",
"assets/assets/images/dance/sword_tells/sword%2520tells%2520(7).webp": "082dca04ca1453b24370591ff671858e",
"assets/assets/images/dance/the_rhythm_of_ink/the%2520rhythm%2520of%2520ink%2520(1).webp": "9d123750244412be567b06baf2402b0d",
"assets/assets/images/dance/the_rhythm_of_ink/the%2520rhythm%2520of%2520ink%2520(2).webp": "1a02c7040c415607724326766aeb00ac",
"assets/assets/images/theatre/cries_and_whispers/cries%2520and%2520whispers%2520(1).webp": "2f19d818403bf2b96f275192b639e0e7",
"assets/assets/images/theatre/cries_and_whispers/cries%2520and%2520whispers%2520(2).webp": "f5ae76a5ce6b6d012d25a51f197c013e",
"assets/assets/images/theatre/cries_and_whispers/cries%2520and%2520whispers%2520(3).webp": "25f272cb5dfe6d6f67fa6aed4efe1824",
"assets/assets/images/theatre/cries_and_whispers/cries%2520and%2520whispers%2520(4).webp": "e9edadac32e2aca4a957d5c3196a4fe1",
"assets/assets/images/theatre/cries_and_whispers/cries%2520and%2520whispers%2520(5).webp": "062d7082713b0f18071b3a8220475bcd",
"assets/assets/images/theatre/cries_and_whispers/cries%2520and%2520whispers%2520(6).webp": "7985638ac3afa206b26fc99e44b138fb",
"assets/assets/images/theatre/cries_and_whispers/cries%2520and%2520whispers%2520(7).webp": "5870f2ed06b62e4e46de04dd8a62a4f9",
"assets/assets/images/theatre/cries_and_whispers/cries%2520and%2520whispers%2520(8).webp": "51ef4dcc2bb69a973cc58a3cfdde989f",
"assets/FontManifest.json": "f4be26b976f19a1d621bda86ae9eb243",
"assets/fonts/MaterialIcons-Regular.otf": "2861d6d9f79ebf8cbf312874eeb981ae",
"assets/NOTICES": "53fe91ebcfcc744731f7580e36699249",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "f81717c317690bdbc36370706d238b4b",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "dbcb5afdfaf66865651c9236b0e318c3",
"/": "dbcb5afdfaf66865651c9236b0e318c3",
"main.dart.js": "8a9b61fe642fa0a10571cd9b3728abe0",
"manifest.json": "ded94bead9b1a3c7326a516e66044051",
"version.json": "8ee01f8bbc104d9dbfc56c1e3ad320e2"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
