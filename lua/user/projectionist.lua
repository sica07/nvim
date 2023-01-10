vim.g.projectionist_heuristics = {
  artisan = {
    ['*'] = {
      start = 'sail up',
      console = 'sail tinker',
      make = 'npm run dev',
    },
    ['app/Models/*.php'] = {
      type = 'model',
    },
    ['app/Http/Controllers/*.php'] = {
      type = 'controller',
    },
    ['routes/*.php'] = {
      type = 'route',
    },
    ['database/migrations/*.php'] = {
      type = 'migration',
    },
    ['app/*.php'] = {
      type = 'source',
      alternate = {
        'tests/Unit/{}Test.php',
        'tests/Feature/{}Test.php',
      },
      template = {
        "<?php",
        "",
        "declare(strict_types=1);",
        "",
        "namespace App\\{camelcase|capitalize|dirname|backslash};",
        "",
        "class {camelcase|basename}",
        "{open}",
        "{close}"
      }
    },
    ['tests/Feature/*Test.php'] = {
      type = 'test',
      alternate = 'app/{}.php',
      template = {
        "<?php",
        "",
        "declare(strict_types=1);",
        "",
        "namespace Tests\\Future\\{camelcase|capitalize|dirname|backslash};",
        "",
        "use Tests\\TestCase;",
        "",
        "class {camelcase|basename}Test extends TestCase",
        "{open}",
        "{close}"
      }
    },
    ['tests/Unit/*Test.php'] = {
      type = 'test',
      alternate = 'app/{}.php',
      template = {
        "<?php",
        "",
        "declare(strict_types=1);",
        "",
        "namespace Tests\\Unit\\{camelcase|capitalize|dirname|backslash};",
        "",
        "use PHPUnit\\Framework\\TestCase;",
        "",
        "class {camelcase|basename}Test extends TestCase",
        "{open}",
        "{close}"
      }

    },
  },
}
