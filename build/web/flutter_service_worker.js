'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "b61b82051df7c78226ec8b5d00752944",
"assets/AssetManifest.bin.json": "43cf43d9e996ef29dfdf83fa7abb70b7",
"assets/AssetManifest.json": "dcf8bde045cd7fd57d94a5685fe8dbec",
"assets/assets/images/cover/cover%2520(1).jpg": "e0ad04998d22ed4f2cd093d876961516",
"assets/assets/images/cover/cover%2520(11).jpg": "867e225e654265d64d2c26a17f56ac0b",
"assets/assets/images/cover/cover%2520(12).jpg": "5f81dad03c4ceb75e57e2459efe2f25c",
"assets/assets/images/cover/cover%2520(13).jpg": "9658f0275af454128751b89ccb6528c9",
"assets/assets/images/cover/cover%2520(14).jpg": "5f64243b4a68d60aff36c9286de553f6",
"assets/assets/images/cover/cover%2520(15).jpg": "797de1f98ef3b918b650d799fbdb0ad0",
"assets/assets/images/cover/cover%2520(16).JPG": "a2700207ac955cdb91eb503fc3009e85",
"assets/assets/images/cover/cover%2520(17).JPG": "5fcd4bd787dd2a28bef8bfca564aecad",
"assets/assets/images/cover/cover%2520(18).JPG": "2a1c8314e30499fd0b7f29adc0ac89dc",
"assets/assets/images/cover/cover%2520(19).JPG": "e1ca934033b6ea50b5c1401e929fc1a2",
"assets/assets/images/cover/cover%2520(2).jpg": "ac50129075a58869fda4a33f21d1e27e",
"assets/assets/images/cover/cover%2520(20).JPG": "b721a0378eeec99d196daf78ac3e1671",
"assets/assets/images/cover/cover%2520(21).JPG": "0291e6c9b7c6b4a294e215195b142e2b",
"assets/assets/images/cover/cover%2520(22).JPG": "90242764183a7ca1ce64035e67cec9b6",
"assets/assets/images/cover/cover%2520(23).jpg": "c6164859680b4fc2bf6225b631afec6b",
"assets/assets/images/cover/cover%2520(24).jpg": "422e338177ae8004cab3fb7e070d40db",
"assets/assets/images/cover/cover%2520(25).jpg": "31ffb0d9e2a1e68ca3c68a8ec5269042",
"assets/assets/images/cover/cover%2520(26).jpg": "06b1f500ae0fe76d1d513831b88267a5",
"assets/assets/images/cover/cover%2520(3).jpg": "29824bbd479dbc4321d1b9dd37662624",
"assets/assets/images/cover/cover%2520(5).jpg": "ca4fdf027f9d15c36de9120abc9cef7d",
"assets/assets/images/cover/cover%2520(6).jpg": "298dff78f92f3c6a28176e622965b868",
"assets/assets/images/cover/cover%2520(7).jpg": "e8684aa03787c10ad3001088dc659927",
"assets/assets/images/cover/cover%2520(8).jpg": "ae11a20ce1b2ac4cf632aa4f676188fd",
"assets/assets/images/dance/areca_nuts/areca_nuts%2520(1).jpg": "19a6d1d874c2b89debb9d1c148ef2c60",
"assets/assets/images/dance/areca_nuts/areca_nuts%2520(2).jpg": "ca4fdf027f9d15c36de9120abc9cef7d",
"assets/assets/images/dance/areca_nuts/areca_nuts%2520(3).jpg": "9658f0275af454128751b89ccb6528c9",
"assets/assets/images/dance/areca_nuts/areca_nuts%2520(4).jpg": "5f64243b4a68d60aff36c9286de553f6",
"assets/assets/images/dance/areca_nuts/areca_nuts%2520(5).jpg": "298dff78f92f3c6a28176e622965b868",
"assets/assets/images/dance/my_name_is_shi/my_name_is_shi%2520(1).JPG": "559bfd82bf2ebcfc064473e68b56fc03",
"assets/assets/images/dance/my_name_is_shi/my_name_is_shi%2520(2).jpg": "867e225e654265d64d2c26a17f56ac0b",
"assets/assets/images/dance/my_name_is_shi/my_name_is_shi%2520(3).jpg": "c6164859680b4fc2bf6225b631afec6b",
"assets/assets/images/dance/my_name_is_shi/my_name_is_shi%2520(4).jpg": "31ffb0d9e2a1e68ca3c68a8ec5269042",
"assets/assets/images/dance/nightmare/nightmare%2520(1).jpg": "e8684aa03787c10ad3001088dc659927",
"assets/assets/images/dance/nightmare/nightmare%2520(2).jpg": "797de1f98ef3b918b650d799fbdb0ad0",
"assets/assets/images/dance/nightmare/nightmare%2520(3).JPG": "39c048b82c4af93ceb81ea35a1c7f166",
"assets/assets/images/dance/nightmare/nightmare%2520(4).jpg": "422e338177ae8004cab3fb7e070d40db",
"assets/assets/images/dance/roaming_dream/roaming_dream%2520(1).JPG": "0081377e7788e3203bdfdad6e70e10a8",
"assets/assets/images/dance/roaming_dream/roaming_dream%2520(1).png": "d0d0565b5aad707971ae3a6ce370ff76",
"assets/assets/images/dance/roaming_dream/roaming_dream%2520(2).jpg": "ae11a20ce1b2ac4cf632aa4f676188fd",
"assets/assets/images/dance/sword_tells/sword_tells%2520(1).jpg": "a2a9345a939b0b3af1a9deae19ad6d73",
"assets/assets/images/dance/sword_tells/sword_tells%2520(2).JPG": "3ca9c79b5769f33442b1d17d7798df8b",
"assets/assets/images/dance/sword_tells/sword_tells%2520(3).JPG": "d98b085b6019c7d2cb468ea17ea2bd12",
"assets/assets/images/dance/sword_tells/sword_tells%2520(4).jpg": "8787abd9b8b1ad87dfb980509d671c91",
"assets/assets/images/dance/sword_tells/sword_tells%2520(5).JPG": "2f2d5a64f92dbce5543f8fd1c8df6ad8",
"assets/assets/images/dance/sword_tells/sword_tells%2520(6).jpg": "5f81dad03c4ceb75e57e2459efe2f25c",
"assets/assets/images/dance/sword_tells/sword_tells%2520(7).jpg": "06b1f500ae0fe76d1d513831b88267a5",
"assets/assets/images/dance/the_rhythm_of_ink/the_rhythm_of_ink%2520(1).JPEG": "8b0484d704d377ba4ffc5a03374955f6",
"assets/assets/images/dance/the_rhythm_of_ink/the_rhythm_of_ink%2520(2).JPEG": "f4c2f63f1479f7ef77b51fc986ff10d8",
"assets/assets/images/theatre/cries_and_whispers/cries_and_whispers%2520(1).JPG": "a2700207ac955cdb91eb503fc3009e85",
"assets/assets/images/theatre/cries_and_whispers/cries_and_whispers%2520(2).JPG": "2a1c8314e30499fd0b7f29adc0ac89dc",
"assets/assets/images/theatre/cries_and_whispers/cries_and_whispers%2520(3).JPG": "e1ca934033b6ea50b5c1401e929fc1a2",
"assets/assets/images/theatre/cries_and_whispers/cries_and_whispers%2520(4).JPG": "25a941f2adb6fc5c327a7dc2e1d8e09c",
"assets/assets/images/theatre/cries_and_whispers/cries_and_whispers%2520(5).JPG": "b721a0378eeec99d196daf78ac3e1671",
"assets/assets/images/theatre/cries_and_whispers/cries_and_whispers%2520(6).JPG": "0291e6c9b7c6b4a294e215195b142e2b",
"assets/assets/images/theatre/cries_and_whispers/cries_and_whispers%2520(7).JPG": "90242764183a7ca1ce64035e67cec9b6",
"assets/assets/images/theatre/cries_and_whispers/cries_and_whispers%2520(8).JPG": "9bca3df5d1b1af4b610a17b879b66808",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
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
"flutter_bootstrap.js": "0db64037ce4046ca6e11e32cc00eaa9f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "dbcb5afdfaf66865651c9236b0e318c3",
"/": "dbcb5afdfaf66865651c9236b0e318c3",
"main.dart.js": "598f60069a45cc2c123dddd472971d09",
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
