<?php declare(strict_types = 1); ?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Docker Compose Demo</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/kognise/water.css@latest/dist/dark.min.css">
</head>
<body>

    <h1>This is a Docker PHP Compose Demo Page.</h1>
    <p>This content is being served by an Nginx container.</p>

    <div>
        <?php 
            phpinfo();
        ?>
    </div>

</body>
</html>
