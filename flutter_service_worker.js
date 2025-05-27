'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"wedding_icon.png": "d41d8cd98f00b204e9800998ecf8427e",
"icons/Icon-maskable-192.png": "d41d8cd98f00b204e9800998ecf8427e",
"icons/Icon-192.png": "d41d8cd98f00b204e9800998ecf8427e",
"icons/Icon-maskable-512.png": "d41d8cd98f00b204e9800998ecf8427e",
"icons/Icon-512.png": "d41d8cd98f00b204e9800998ecf8427e",
"assets/fonts/MaterialIcons-Regular.otf": "5730aaf5db157da9f789f130e724c621",
"assets/AssetManifest.bin.json": "fd6e17cc3fa67b3c2b33c163472dd2ef",
"assets/AssetManifest.bin": "cb26167017e3ca28f27da947e1f73c41",
"assets/AssetManifest.json": "4bc48e83f6f00a5fc5053b988104d2b5",
"assets/assets/fonts/PlayfairDisplay-Regular.ttf": "1a28efdbd2876d90e554a67faabad24b",
"assets/assets/fonts/PlayfairDisplay-Italic.ttf": "f38e89a44737b67d5dba2d9c860c3b65",
"assets/assets/fonts/PlayfairDisplay-Bold.ttf": "9b38798112efb7cf6eca1de031cec4ca",
"assets/assets/fonts/PlayfairDisplay-BoldItalic.ttf": "c6bd3951c4797106c1dac753a795534a",
"assets/assets/images/venue.jpg": "bf84f03bc9f5e69f80f3d542cd0b4814",
"assets/assets/images/story2.jpg": "7bd1bd671ce8035d83785402324d8f43",
"assets/assets/images/pattern.svg": "02df8ac9ba5ad42e4f6e5317741fcc8f",
"assets/assets/images/pattern.png": "9d5bf0de20b2faf2c23994efd7566236",
"assets/assets/images/love.png": "93921696537a4445dd1921f6c1f19733",
"assets/assets/images/story3.jpg": "ff61f9b9ee5383483e17f280a45fa446",
"assets/assets/images/story1.jpg": "38db7164b0ad04a670dd62bd3e24f727",
"assets/assets/images/hero_bg.jpg": "fcfd774bff264e6a0ec2271a95d3c32d",
"assets/assets/images/church.jpg": "41be9f7a150cd161d7fd9c8f8a42ad32",
"assets/assets/images/hero_bg1.jpg": "0910bb6bc4c8faf3cd798b48e93279e0",
"assets/assets/images/rings.png": "de9110f622cbdaf072a1899a1e75ef26",
"assets/assets/images/bride.jpg": "d2c10203b76a9a5b65cd8fc243394af6",
"assets/assets/images/wedding_marker.png": "7215ee9c7d9dc229d2921a40e899ec5f",
"assets/assets/images/champagne.png": "387f935ee7c7ad4c82d56535d45a3124",
"assets/assets/images/wedding_photosession.jpg": "6a36bcbc383b7479614b8568ecaf02e5",
"assets/assets/images/groom.jpg": "8667c3d2ae812a1b0da4d9f8ef806e30",
"assets/assets/images/flowers.png": "a62b770bf3056ad06116fea108d61e11",
"assets/assets/images/franopol.jpg": "672e9c7e7af6a11256b2ff350bdd13e7",
"assets/assets/images/wedding_registration.jpg.webp": "57a6e932e0139cd6a22622d6a9cb6d7e",
"assets/assets/images/hearth.png": "d802a78e19d968c43e1b1bd904325cb4",
"assets/assets/images/wedding_cake.png": "ecaa57aa28bbc01a1f066477c87cc16b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "825e75415ebd366b740bb49659d7a5c6",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/FontManifest.json": "c6b42c80a270f11c12b465049049458f",
"assets/NOTICES": "f9aee211fbb29db1acaeb276b265eebb",
"main.dart.js": "5e4327b57bbbba08584cafa8b0a55772",
"manifest.json": "7e0930329646215e01fd94c0695a046c",
"version.json": "3d0a8b3e454aa8006e8b32fefcd8e5e3",
"canvaskit/skwasm.js.symbols": "9fe690d47b904d72c7d020bd303adf16",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.wasm": "1c93738510f202d9ff44d36a4760126b",
"canvaskit/canvaskit.wasm": "a37f2b0af4995714de856e21e882325c",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/canvaskit.js.symbols": "27361387bc24144b46a745f1afe92b50",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "c054c2c892172308ca5a0bd1d7a7754b",
"canvaskit/chromium/canvaskit.js.symbols": "f7c5e5502d577306fb6d530b1864ff86",
"flutter_bootstrap.js": "362edbc04f111c3c94ffb562ab6ceca6",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"index.html": "818abca267992d05fce833b8ab617826",
"/": "818abca267992d05fce833b8ab617826",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c"};
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
