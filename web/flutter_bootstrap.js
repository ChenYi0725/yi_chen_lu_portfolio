{{flutter_js}}
{{flutter_build_config}}

// This portfolio does not need offline/PWA caching. Remove registrations left
// by older deployments, then load the current build without registering one.
(async () => {
  if ('serviceWorker' in navigator) {
    const registrations = await navigator.serviceWorker.getRegistrations();
    await Promise.all(registrations.map((registration) => registration.unregister()));
  }
  await _flutter.loader.load();
})();
