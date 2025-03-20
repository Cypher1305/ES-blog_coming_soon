<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ES-Blog - Bientôt Disponible</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.5.1"></script>
    <script src="https://cdn.jsdelivr.net/npm/tsparticles@1.28.0/dist/tsparticles.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@webcomponents/webcomponentsjs@2.5.0/custom-elements-es5-adapter.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@webcomponents/webcomponentsjs@2.5.0/webcomponents-loader.js"></script>
    <script type="module" src="https://cdn.jsdelivr.net/npm/web-particles@1.1.0/dist/web-particles.min.js"></script>
</head>

<body class="items-center justify-center h-full text-gray-800 text-center w-full">
    <web-particles id="tsparticles" class="absolute top-0 left-0 w-full h-full z-0" options='{"fps_limit":60,"interactivity":{"detectsOn":"canvas","events":{"onClick":{"enable":true,"mode":"push"},"onHover":{"enable":true,"mode":"repulse"},"resize":true},"modes":{"push":{"particles_nb":4},"repulse":{"distance":200,"duration":0.4}}},"particles":{"color":{"value":"#00bfff"},"links":{"color":"#00bfff","distance":150,"enable":true,"opacity":0.1,"width":1},"move":{"bounce":false,"direction":"none","enable":true,"outMode":"out","random":false,"speed":1,"straight":false},"number":{"density":{"enable":true,"area":800},"value":80},"opacity":{"value":0.2},"shape":{"type":"circle"},"size":{"random":true,"value":5}},"detectRetina":true}'></web-particles>

    <div class="relative z-10 mt-[85px] bg-white space-y-8 w-[70%] sm:w-[60%] md:w-[50%] lg:w-[15%] justify-center items-center mx-auto">
        <img src="log.png" alt="ES-Blog Logo" class="mx-auto w-36 sm:w-44 md:w-52 h-auto">
        
        <div id="countdown" class="grid grid-flow-col gap-5 text-center auto-cols-max mx-auto">
            <div class="flex flex-col p-4 bg-gray-900 text-white rounded-lg shadow-md">
                <span class="countdown font-mono text-2xl sm:text-4xl md:text-5xl">
                    <span id="days">00</span>
                </span>
                days
            </div>
            <div class="flex flex-col p-4 bg-gray-900 text-white rounded-lg shadow-md">
                <span class="countdown font-mono text-2xl sm:text-4xl md:text-5xl">
                    <span id="hours">00</span>
                </span>
                hours
            </div>
            <div class="flex flex-col p-4 bg-gray-900 text-white rounded-lg shadow-md">
                <span class="countdown font-mono text-2xl sm:text-4xl md:text-5xl">
                    <span id="minutes">00</span>
                </span>
                min
            </div>
            <div class="flex flex-col p-4 bg-gray-900 text-white rounded-lg shadow-md">
                <span class="countdown font-mono text-2xl sm:text-4xl md:text-5xl">
                    <span id="seconds">00</span>
                </span>
                sec
            </div>
        </div>
        
        <h1 class="text-xs sm:text-xl font-bold">Technologies - Inspirations - Connections</h1>
        
        <div id="socials" class="flex justify-center space-x-8">
            <a href="#" target="_blank" class="text-[#00bfff] text-2xl sm:text-3xl md:text-4xl transition-transform transform hover:scale-110"><i class="fab fa-linkedin"></i></a>
            <a href="http://www.youtube.com/@esblogci" target="_blank" class="text-[#00bfff] text-2xl sm:text-3xl md:text-4xl transition-transform transform hover:scale-110"><i class="fab fa-youtube"></i></a>
            <a href="#" target="_blank" class="text-[#00bfff] text-2xl sm:text-3xl md:text-4xl transition-transform transform hover:scale-110"><i class="fab fa-tiktok"></i></a>
            <a href="https://whatsapp.com/channel/0029VaWUvU84tRrqQPPujC2I" target="_blank" class="text-[#00bfff] text-2xl sm:text-3xl md:text-4xl transition-transform transform hover:scale-110"><i class="fab fa-whatsapp"></i></a>
            <a href="https://www.facebook.com/profile.php?id=61558122104581" target="_blank" class="text-[#00bfff] text-2xl sm:text-3xl md:text-4xl transition-transform transform hover:scale-110"><i class="fab fa-facebook"></i></a>
            <a href="#" target="_blank" class="text-[#00bfff] text-2xl sm:text-3xl md:text-4xl transition-transform transform hover:scale-110"><i class="fab fa-instagram"></i></a>
        </div>
        
        <button id="discover-btn" class="hidden px-6 py-3 bg-blue-500 text-white text-lg rounded-lg">Découvrez esblog.info</button>

        <div class="absolute bottom-[-70px] left-1/2 -translate-x-1/2 text-center w-full">
            <p class="mt-1 mx-auto mb-0 text-xs text-gray-600">
                <i class="fas fa-code"></i> and <i class="fas fa-palette"></i> with ❤️ by
                <a href=""><strong>Cypher1305</strong></a>
            </p>
        </div>
    </div>

    <script>
        function updateCountdown() {
            const targetDate = new Date('April 17, 2025 00:20:00').getTime();
            const timer = setInterval(() => {
                const now = new Date().getTime();
                const distance = targetDate - now;

                if (distance < 0) {
                    clearInterval(timer);
                    confetti();
                    document.getElementById("countdown").innerHTML = "C'est parti !";
                    document.getElementById("discover-btn").classList.remove("hidden");
                    document.getElementById("discover-btn").onclick = () => window.location.href = "https://www.esblog.info";
                    return;
                }

                const days = Math.floor(distance / (1000 * 60 * 60 * 24));
                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((distance % (1000 * 60)) / 1000);

                document.getElementById("days").textContent = days.toString().padStart(2, '0');
                document.getElementById("hours").textContent = hours.toString().padStart(2, '0');
                document.getElementById("minutes").textContent = minutes.toString().padStart(2, '0');
                document.getElementById("seconds").textContent = seconds.toString().padStart(2, '0');
            }, 1000);
        }

        updateCountdown();
    </script>

</body>

</html>
