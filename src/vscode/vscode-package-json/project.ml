(**************************************************************************)
(*                                                                        *)
(*                        SuperBOL OSS Studio                             *)
(*                                                                        *)
(*                                                                        *)
(*  Copyright (c) 2023 OCamlPro SAS                                       *)
(*                                                                        *)
(*  All rights reserved.                                                  *)
(*  This source code is licensed under the MIT license found in the       *)
(*  LICENSE.md file in the root directory of this source tree.            *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

open Vscode_json
open Manifest

let vscode_engine = "1.64.0"


let marketplace = Manifest.marketplace
    "ocamlpro"
  ~categories: [
    "Formatters" ;
    "Programming Languages" ;
    "Linters" ;
    "Snippets" ;
    "Other"
  ]

let package =
  Manifest.package
    "superbol"
    ~displayName: "Superbol COBOL"
    ~description: "Provides a COBOL mode in VSCode based on Superbol"
    ~license: "MIT"
    ~version: "0.1.0"
    ~repository: {
      type_ = Some "git" ;
      url = "https://github.com/OCamlPro/superbol-vscode-platform"
    }
    ~homepage: "https://ocamlpro.com/cobol"
    ~author: {
      author_name = "OCamlPro SAS" ;
      author_email = "contact@ocamlpro.com"
    }
    ~keywords: [ "cobol" ; "gnucobol" ]
    ~main: "./out/superbol_vscode_platform.bc.js"
    ~scripts: [
      "package" ,
      "vsce package --out superbol-vscode-platform.vsix --yarn" ;
      "deploy:vsce" ,
      "vsce publish --packagePath superbol-vscode-platform.vsix --yarn" ;
      "deploy:ovsx" ,
      "ovsx publish --yarn"
    ]
    ~dependencies: [
      "polka" , "^1.0.0-next.22" ;
      "sirv" , "^2.0.2" ;
      "vscode-languageclient" , "8.0.2"
    ]
    ~devDependencies: [
      "@types/vscode" , vscode_engine ;
      "esbuild" , "0.15.16" ;
      "fs-extra" , "10.0.1" ;
      "mocha" , "9.2.2" ;
      "npm-run-all" , "4.1.5" ;
      "ovsx" , "0.1.0-next.97d460c" ;
      "prettier" , "^2.5.1" ;
      "vsce" , "2.14.0" ;
      "vscode-test" , "1.6.1"
    ]

let manifest =
  Manifest.vscode
    package
    ~marketplace
    ~engines: ( "^" ^ vscode_engine )
    ~activationEvents: [
      "onLanguage:cobol"
    ]
    ?contributes: None


(*

{
  "name": "vscode-ocaml-skeleton",
  "displayName": "VScode OCaml Skeleton",
  "description": "skeleton for language extensions for VSCode in OCaml",
  "license": "MIT",
  "version": "1.12.2",
  "publisher": "ocamlpro",
  "repository": {
    "type": "git",
    "url": "https://github.com/ocamlpro/vscode-ocaml-skeleton"
  },
  "bugs": {
    "url": "https://github.com/ocamlpro/vscode-ocaml-skeleton/issues"
  },
  "homepage": "https://github.com/ocamlpro/vscode-ocaml-skeleton",
  "main": "./dist/vscode_ocaml_skeleton.bc.js",
  "scripts": {
    "test:esy": "node ./test/runEsyTests.js",
    "test:opam": "node ./test/runOpamTests.js",
    "test:problems": "node ./test/runProblemMatcherTests.js",
    "test": "npm-run-all -s test:*",
    "package": "vsce package --out vscode-ocaml-skeleton.vsix --yarn",
    "deploy:vsce": "vsce publish --packagePath vscode-ocaml-skeleton.vsix --yarn",
    "deploy:ovsx": "ovsx publish --yarn",
    "fmt:check": "prettier . --check",
    "fmt": "prettier . --write"
  },
  "dependencies": {
    "polka": "^1.0.0-next.22",
    "sirv": "^2.0.2",
    "vscode-languageclient": "8.0.2"
  },
  "devDependencies": {
    "@types/vscode": "1.64.0",
    "esbuild": "0.15.16",
    "fs-extra": "10.0.1",
    "mocha": "9.2.2",
    "npm-run-all": "4.1.5",
    "ovsx": "0.1.0-next.97d460c",
    "prettier": "^2.5.1",
    "vsce": "2.14.0",
    "vscode-test": "1.6.1"
  },
  "prettier": {
    "proseWrap": "always",
    "endOfLine": "auto",
    "overrides": [
      {
        "files": "*.yml",
        "options": {
          "proseWrap": "preserve"
        }
      }
    ]
  },
  "engines": {
    "vscode": "^1.64.0"
  },
  "categories": [
    "Programming Languages"
  ],
  "activationEvents": [
    "onLanguage:ocaml",
    "onLanguage:ocaml.interface",
    "onLanguage:reason",
    "onLanguage:ocaml.ocamllex",
    "onLanguage:ocaml.menhir",
    "onLanguage:dune",
    "onLanguage:dune-project",
    "onLanguage:dune-workspace",
    "onLanguage:cram",
    "onCommand:ocaml.select-sandbox",
    "onCommand:ocaml.open-terminal",
    "onCommand:ocaml.open-terminal-select",
    "onCommand:ocaml.open-ast-explorer-to-the-side",
    "onCommand:ocaml.show-preprocessed-document",
    "onCommand:ocaml.open-pp-editor-and-ast-explorer",
    "onCommand:ocaml.stop-documentation-server",
    "onCustomEditor:ast-editor",
    "onCustomEditor:cm-files-editor",
    "workspaceContains:**/dune-workspace",
    "workspaceContains:**/dune",
    "workspaceContains:**/dune-project",
    "workspaceContains:**/*.opam",
    "workspaceContains:**/*.ml",
    "workspaceContains:**/*.mli",
    "workspaceContains:**/*.mll",
    "workspaceContains:**/*.mly",
    "workspaceContains:**/*.re",
    "workspaceContains:**/*.rei"
  ],
  "icon": "assets/logo.png",
  "contributes": {
    "viewsWelcome": [
      {
        "view": "ocaml-sandbox",
        "contents": "In order to manage your sandbox, you can open a folder containing an Opam switch, or select an Opam switch as a sandbox.\n[Open Folder](command:vscode.openFolder)\n[Select Sandbox](command:ocaml.select-sandbox)"
      }
    ],
    "viewsContainers": {
      "activitybar": [
        {
          "id": "ocaml-explorer",
          "title": "OCaml",
          "icon": "assets/logo.svg"
        }
      ]
    },
    "views": {
      "ocaml-explorer": [
        {
          "id": "ocaml-sandbox",
          "name": "Sandbox"
        },
        {
          "id": "ocaml-switches",
          "name": "Opam Switches"
        },
        {
          "id": "ocaml-commands",
          "name": "Commands"
        },
        {
          "id": "ocaml-help",
          "name": "Help and feedback"
        }
      ]
    },
    "commands": [
      {
        "command": "ocaml.select-sandbox",
        "category": "OCaml",
        "title": "Select a Sandbox for this Workspace"
      },
      {
        "command": "ocaml.server.restart",
        "category": "OCaml",
        "title": "Restart Language Server"
      },
      {
        "command": "ocaml.open-terminal",
        "category": "OCaml",
        "title": "Create Terminal (Current Sandbox)"
      },
      {
        "command": "ocaml.open-terminal-select",
        "category": "OCaml",
        "title": "Create Terminal (Select a Sandbox)"
      },
      {
        "command": "ocaml.switch-impl-intf",
        "category": "OCaml",
        "title": "Switch implementation/interface",
        "icon": {
          "light": "assets/switch-impl-intf.light.svg",
          "dark": "assets/switch-impl-intf.dark.svg"
        }
      },
      {
        "command": "ocaml.refresh-switches",
        "category": "OCaml",
        "title": "Refresh Switches",
        "icon": {
          "light": "assets/refresh-light.svg",
          "dark": "assets/refresh-dark.svg"
        }
      },
      {
        "command": "ocaml.refresh-sandbox",
        "category": "OCaml",
        "title": "Refresh Sandbox",
        "icon": {
          "light": "assets/refresh-light.svg",
          "dark": "assets/refresh-dark.svg"
        }
      },
      {
        "command": "ocaml.install-sandbox",
        "category": "OCaml",
        "title": "Install Packages",
        "icon": {
          "light": "assets/plus-light.svg",
          "dark": "assets/plus-dark.svg"
        }
      },
      {
        "command": "ocaml.upgrade-sandbox",
        "category": "OCaml",
        "title": "Upgrade Packages",
        "icon": {
          "light": "assets/arrow-circle-up-light.svg",
          "dark": "assets/arrow-circle-up-dark.svg"
        }
      },
      {
        "command": "ocaml.remove-switch",
        "category": "OCaml",
        "title": "Remove Switch",
        "icon": {
          "light": "assets/x-light.svg",
          "dark": "assets/x-dark.svg"
        }
      },
      {
        "command": "ocaml.uninstall-sandbox-package",
        "category": "OCaml",
        "title": "Uninstall Package",
        "icon": {
          "light": "assets/x-light.svg",
          "dark": "assets/x-dark.svg"
        }
      },
      {
        "command": "ocaml.open-switches-documentation",
        "category": "OCaml",
        "title": "Open Documentation",
        "icon": {
          "light": "assets/document-search-light.svg",
          "dark": "assets/document-search-dark.svg"
        }
      },
      {
        "command": "ocaml.generate-sandbox-documentation",
        "category": "OCaml",
        "title": "Generate Documentation",
        "icon": {
          "light": "assets/book-open-light.svg",
          "dark": "assets/book-open-dark.svg"
        }
      },
      {
        "command": "ocaml.open-sandbox-documentation",
        "category": "OCaml",
        "title": "Open Documentation",
        "icon": {
          "light": "assets/document-search-light.svg",
          "dark": "assets/document-search-dark.svg"
        }
      },
      {
        "command": "ocaml.stop-documentation-server",
        "category": "OCaml",
        "title": "Stop Documentation Server"
      },
      {
        "command": "ocaml.next-hole",
        "category": "OCaml",
        "title": "Jump to Next Typed Hole"
      },
      {
        "command": "ocaml.prev-hole",
        "category": "OCaml",
        "title": "Jump to Previous Typed Hole"
      },
      {
        "command": "ocaml.current-dune-file",
        "category": "OCaml",
        "title": "Open Dune File (located in the same folder)"
      },
      {
        "command": "ocaml.open-repl",
        "category": "OCaml",
        "title": "Open REPL"
      },
      {
        "command": "ocaml.evaluate-selection",
        "category": "OCaml",
        "title": "Evaluate Selection"
      },
      {
        "command": "ocaml.open-ast-explorer-to-the-side",
        "category": "OCaml",
        "title": "Open AST explorer"
      },
      {
        "command": "ocaml.show-preprocessed-document",
        "category": "OCaml",
        "title": "Show Preprocessed Document"
      },
      {
        "command": "ocaml.reveal-ast-node",
        "category": "OCaml",
        "title": "Reveal Ast Node"
      },
      {
        "command": "ocaml.switch-hover-mode",
        "category": "OCaml",
        "title": "Switch to hover AST reveal mode"
      },
      {
        "command": "ocaml.open-pp-editor-and-ast-explorer",
        "category": "OCaml",
        "title": "Open both Preprocessed Document and AST explorer to the side"
      },
      {
        "command": "ocaml.open-ocamllsp-output",
        "category": "OCaml",
        "title": "Show OCaml Language Server Output"
      },
      {
        "command": "ocaml.open-ocaml-platform-ext-output",
        "category": "OCaml",
        "title": "Show OCaml Platform Extension Output"
      },
      {
        "command": "ocaml.open-ocaml-commands-output",
        "category": "OCaml",
        "title": "Show OCaml Commands Output"
      }
    ],
    "keybindings": [
      {
        "command": "ocaml.switch-impl-intf",
        "key": "Alt+O",
        "when": "editorLangId == ocaml || editorLangId == ocaml.interface || editorLangId == reason || editorLangId == ocaml.ocamllex || editorLangId == ocaml.menhir"
      },
      {
        "command": "editor.action.codeAction",
        "key": "Alt+D",
        "args": {
          "kind": "destruct"
        },
        "when": "editorLangId == ocaml || editorLangId == reason"
      },
      {
        "command": "editor.action.codeAction",
        "key": "Alt+C",
        "args": {
          "kind": "construct"
        },
        "when": "editorLangId == ocaml"
      },
      {
        "command": "editor.action.codeAction",
        "key": "Alt+P",
        "args": {
          "kind": "inferred_intf"
        },
        "when": "editorLangId == ocaml.interface || editorLangId == reason"
      },
      {
        "command": "ocaml.evaluate-selection",
        "key": "Shift+Enter",
        "when": "editorTextFocus && editorLangId == ocaml || editorTextFocus && editorLangId == ocaml.interface || editorTextFocus && editorLangId == reason || editorTextFocus && editorLangId == ocaml.ocamllex || editorTextFocus && editorLangId == ocaml.menhir"
      },
      {
        "command": "ocaml.next-hole",
        "key": "Alt+Y",
        "when": "editorLangId == ocaml || editorLangId == ocaml.interface || editorLangId == reason || editorLangId == ocaml.ocamllex"
      },
      {
        "command": "ocaml.prev-hole",
        "key": "Shift+Alt+Y",
        "when": "editorLangId == ocaml || editorLangId == ocaml.interface || editorLangId == reason || editorLangId == ocaml.ocamllex"
      },
      {
        "command": "ocaml.reveal-ast-node",
        "key": "Alt+N",
        "when": "editorTextFocus && editorLangId == ocaml || editorLangId == ocaml.interface "
      },
      {
        "command": "ocaml.switch-hover-mode",
        "key": "Alt+H",
        "when": "editorTextFocus && editorLangId == ocaml || editorLangId == ocaml.interface "
      }
    ],
    "menus": {
      "editor/context": [
        {
          "command": "ocaml.evaluate-selection",
          "group": "OCaml",
          "when": "editorTextFocus && editorLangId == ocaml || editorTextFocus && editorLangId == ocaml.interface || editorTextFocus && editorLangId == reason || editorTextFocus && editorLangId == ocaml.ocamllex || editorTextFocus && editorLangId == ocaml.menhir"
        },
        {
          "command": "ocaml.reveal-ast-node",
          "group": "OCaml",
          "when": "editorTextFocus && editorLangId == ocaml || editorTextFocus && editorLangId == ocaml.interface"
        }
      ],
      "commandPalette": [
        {
          "command": "ocaml.current-dune-file",
          "when": "editorIsOpen"
        },
        {
          "command": "ocaml.next-hole",
          "when": "editorLangId == ocaml || editorLangId == ocaml.interface || editorLangId == reason || editorLangId == ocaml.ocamllex"
        },
        {
          "command": "ocaml.prev-hole",
          "when": "editorLangId == ocaml || editorLangId == ocaml.interface || editorLangId == reason || editorLangId == ocaml.ocamllex"
        },
        {
          "command": "ocaml.refresh-switches",
          "when": "false"
        },
        {
          "command": "ocaml.refresh-sandbox",
          "when": "false"
        },
        {
          "command": "ocaml.install-sandbox",
          "when": "false"
        },
        {
          "command": "ocaml.uninstall-sandbox-package",
          "when": "false"
        },
        {
          "command": "ocaml.stop-documentation-server",
          "when": "ocaml.documentation-server-on"
        },
        {
          "command": "ocaml.upgrade-sandbox",
          "when": "false"
        },
        {
          "command": "ocaml.remove-switch",
          "when": "false"
        },
        {
          "command": "ocaml.open-switches-documentation",
          "when": "false"
        },
        {
          "command": "ocaml.open-sandbox-documentation",
          "when": "false"
        },
        {
          "command": "ocaml.generate-sandbox-documentation",
          "when": "false"
        }
      ],
      "editor/title": [
        {
          "command": "ocaml.switch-impl-intf",
          "key": "Alt+O",
          "when": "editorLangId == ocaml || editorLangId == ocaml.interface || editorLangId == reason || editorLangId == ocaml.ocamllex || editorLangId == ocaml.menhir",
          "group": "navigation"
        }
      ],
      "view/title": [
        {
          "command": "ocaml.refresh-switches",
          "when": "view == ocaml-switches",
          "group": "navigation"
        },
        {
          "command": "ocaml.refresh-sandbox",
          "when": "view == ocaml-sandbox",
          "group": "navigation"
        },
        {
          "command": "ocaml.install-sandbox",
          "when": "view == ocaml-sandbox",
          "group": "navigation"
        },
        {
          "command": "ocaml.upgrade-sandbox",
          "when": "view == ocaml-sandbox",
          "group": "navigation"
        }
      ],
      "view/item/context": [
        {
          "command": "ocaml.remove-switch",
          "when": "view == ocaml-switches && viewItem == opam-switch",
          "group": "inline"
        },
        {
          "command": "ocaml.open-switches-documentation",
          "when": "view == ocaml-switches && viewItem == package-with-doc",
          "group": "inline"
        },
        {
          "command": "ocaml.open-sandbox-documentation",
          "when": "view == ocaml-sandbox && viewItem == package-with-doc",
          "group": "inline@1"
        },
        {
          "command": "ocaml.generate-sandbox-documentation",
          "when": "view == ocaml-sandbox",
          "group": "inline@2"
        },
        {
          "command": "ocaml.uninstall-sandbox-package",
          "when": "view == ocaml-sandbox",
          "group": "inline@3"
        }
      ]
    },
    "configuration": {
      "title": "VScode OCaml Skeleton",
      "properties": {
        "ocaml.sandbox": {
          "type": "object",
          "default": null,
          "description": "Determines where to find the sandbox for a given project"
        },
        "ocaml.server.extraEnv": {
          "type": [
            "null",
            "object"
          ],
          "default": null,
          "markdownDescription": "Extra environment variables that will be passed to OCaml LSP executable. Useful for debugging purposes mostly."
        },
        "ocaml.server.args": {
          "type": "array",
          "items": "string",
          "default": [],
          "markdownDescription": "Extra arguments to pass to ocamllsp."
        },
        "ocaml.dune.autoDetect": {
          "type": "boolean",
          "default": true,
          "description": "Controls whether dune tasks should be automatically detected."
        },
        "ocaml.trace.server": {
          "description": "Controls the logging output of the language server. Valid settings are `off`, `messages`, or `verbose`.",
          "type": "string",
          "enum": [
            "off",
            "messages",
            "verbose"
          ],
          "default": "off"
        },
        "ocaml.useOcamlEnv": {
          "type": "boolean",
          "default": true,
          "description": "Controls whether to use ocaml-env (if available) for opam commands from OCaml for Windows."
        },
        "ocaml.terminal.shell.linux": {
          "description": "The path of the shell that the sandbox terminal uses on Linux",
          "type": [
            "string",
            "null"
          ],
          "default": null
        },
        "ocaml.terminal.shell.osx": {
          "description": "The path of the shell that the sandbox terminal uses on macOS",
          "type": [
            "string",
            "null"
          ],
          "default": null
        },
        "ocaml.terminal.shell.windows": {
          "description": "The path of the shell that the sandbox terminal uses on Windows",
          "type": [
            "string",
            "null"
          ],
          "default": null
        },
        "ocaml.terminal.shellArgs.linux": {
          "description": "The command line arguments that the sandbox terminal uses on Linux",
          "type": [
            "array",
            "null"
          ],
          "items": "string",
          "default": null
        },
        "ocaml.terminal.shellArgs.osx": {
          "description": "The command line arguments that the sandbox terminal uses on macOS",
          "type": [
            "array",
            "null"
          ],
          "items": "string",
          "default": null
        },
        "ocaml.terminal.shellArgs.windows": {
          "description": "The command line arguments that the sandbox terminal uses on Window",
          "type": [
            "array",
            "null"
          ],
          "items": "string",
          "default": null
        },
        "ocaml.repl.path": {
          "description": "The path of the REPL that the extension uses",
          "type": [
            "string",
            "null"
          ],
          "default": null
        },
        "ocaml.repl.args": {
          "description": "The REPL arguments that the extension uses",
          "type": [
            "array",
            "null"
          ],
          "items": "string",
          "default": null
        },
        "ocaml.repl.useUtop": {
          "type": "boolean",
          "default": true,
          "description": "Controls whether to use Utop for the REPL if it is installed in the current switch."
        }
      }
    },
    "configurationDefaults": {
      "[ocaml]": {
        "editor.tabSize": 2,
        "editor.insertSpaces": true
      },
      "[dune]": {
        "editor.tabSize": 1,
        "editor.insertSpaces": true
      },
      "[dune-project]": {
        "editor.tabSize": 1,
        "editor.insertSpaces": true
      },
      "[dune-workspace]": {
        "editor.tabSize": 1,
        "editor.insertSpaces": true
      },
      "[cram]": {
        "editor.tabSize": 2,
        "editor.insertSpaces": true
      }
    },
    "problemMatchers": [
      {
        "name": "ocamlc",
        "fileLocation": [
          "relative",
          "${workspaceFolder}"
        ],
        "pattern": [
          {
            "regexp": "^\\s*\\bFile\\b\\s*\"(.*)\",\\s*\\blines?\\b\\s*(\\d+)(?:-(\\d+))?(?:,\\s*\\bcharacters\\b\\s*(\\d+)-(\\d+)\\s*)?:\\s*$",
            "file": 1,
            "line": 2,
            "endLine": 3,
            "column": 4,
            "endColumn": 5
          },
          {
            "regexp": "^(?:\\s*\\bParse\\b\\s*)?\\s*\\b([Ee]rror|Warning)\\b\\s*(?:(?:\\(\\s*\\bwarning\\b\\s*)?(\\d+)\\)?)?\\s*:\\s*(.*)$",
            "severity": 1,
            "code": 2,
            "message": 3
          }
        ]
      }
    ],
    "taskDefinitions": [
      {
        "type": "dune"
      }
    ],
    "languages": [
      {
        "id": "dune",
        "aliases": [
          "dune"
        ],
        "extensions": [
          "dune",
          "jbuild"
        ],
        "configuration": "./languages/dune.json"
      },
      {
        "id": "dune-project",
        "aliases": [
          "dune project"
        ],
        "extensions": [
          "dune-project"
        ],
        "configuration": "./languages/dune.json"
      },
      {
        "id": "dune-workspace",
        "aliases": [
          "dune workspace"
        ],
        "filenames": [
          "dune-workspace"
        ],
        "filenamePatterns": [
          "dune-workspace.*"
        ],
        "configuration": "./languages/dune.json"
      },
      {
        "id": "ocaml.merlin",
        "aliases": [
          "Merlin",
          "merlin"
        ],
        "extensions": [
          ".merlin"
        ]
      },
      {
        "id": "ocaml",
        "aliases": [
          "OCaml",
          "ocaml"
        ],
        "extensions": [
          ".ml",
          ".eliom",
          ".ocamlinit"
        ],
        "configuration": "./languages/ocaml.json"
      },
      {
        "id": "ocaml.interface",
        "aliases": [
          "OCaml Interface",
          "ocaml interface"
        ],
        "extensions": [
          ".mli",
          ".eliomi"
        ],
        "configuration": "./languages/ocaml.json"
      },
      {
        "id": "ocaml.opam",
        "aliases": [
          "opam"
        ],
        "filenames": [
          "opam"
        ],
        "extensions": [
          ".opam",
          ".opam.locked",
          ".opam.template"
        ],
        "configuration": "./languages/opam.json"
      },
      {
        "id": "ocaml.opam-install",
        "aliases": [
          "opam install"
        ],
        "extensions": [
          ".install"
        ],
        "configuration": "./languages/opam-install.json"
      },
      {
        "id": "ocaml.META",
        "aliases": [
          "META",
          "meta"
        ],
        "filenames": [
          "META"
        ],
        "configuration": "./languages/META.json"
      },
      {
        "id": "ocaml.ocamlbuild",
        "aliases": [
          "OCamlbuild",
          "ocamlbuild"
        ],
        "extensions": [
          "_tags"
        ],
        "configuration": "./languages/ocamlbuild.json"
      },
      {
        "id": "ocaml.oasis",
        "aliases": [
          "OASIS",
          "oasis"
        ],
        "extensions": [
          "_oasis"
        ],
        "configuration": "./languages/oasis.json"
      },
      {
        "id": "ocaml.ocamldoc",
        "aliases": [
          "OCamldoc",
          "ocamldoc"
        ],
        "extensions": [
          ".mld"
        ]
      },
      {
        "id": "ocaml.ocamlformat",
        "aliases": [
          "OCamlFormat",
          "ocamlformat"
        ],
        "extensions": [
          ".ocamlformat"
        ],
        "configuration": "./languages/ocamlformat.json"
      },
      {
        "id": "ocaml.ocamllex",
        "aliases": [
          "OCamllex",
          "ocamllex"
        ],
        "extensions": [
          ".mll"
        ],
        "configuration": "./languages/ocamllex.json"
      },
      {
        "id": "ocaml.menhir",
        "aliases": [
          "Menhir",
          "menhir",
          "OCamlyacc",
          "ocamlyacc"
        ],
        "extensions": [
          ".mly"
        ],
        "configuration": "./languages/menhir.json"
      },
      {
        "id": "atd",
        "aliases": [
          "ATD",
          "atd"
        ],
        "extensions": [
          ".atd"
        ],
        "configuration": "./languages/ocaml.json"
      },
      {
        "id": "reason",
        "aliases": [
          "Reason",
          "reason"
        ],
        "extensions": [
          ".re",
          ".rei"
        ],
        "configuration": "./languages/reason.json"
      },
      {
        "id": "cram",
        "aliases": [
          "Cram Test",
          "Cram",
          "cram"
        ],
        "extensions": [
          ".t"
        ]
      }
    ],
    "grammars": [
      {
        "language": "dune",
        "scopeName": "source.dune",
        "path": "./syntaxes/dune.json"
      },
      {
        "language": "dune-project",
        "scopeName": "source.dune-project",
        "path": "./syntaxes/dune-project.json"
      },
      {
        "language": "dune-workspace",
        "scopeName": "source.dune-workspace",
        "path": "./syntaxes/dune-workspace.json"
      },
      {
        "language": "ocaml.merlin",
        "scopeName": "source.ocaml.merlin",
        "path": "./syntaxes/merlin.json"
      },
      {
        "scopeName": "markdown.ocaml.codeblock",
        "path": "./syntaxes/ocaml-markdown-codeblock.json",
        "injectTo": [
          "text.html.markdown"
        ],
        "embeddedLanguages": {
          "meta.embedded.block.ocaml": "ocaml"
        }
      },
      {
        "language": "ocaml",
        "scopeName": "source.ocaml",
        "path": "./syntaxes/ocaml.json"
      },
      {
        "language": "ocaml.interface",
        "scopeName": "source.ocaml.interface",
        "path": "./syntaxes/ocaml.interface.json"
      },
      {
        "language": "ocaml.ocamlbuild",
        "scopeName": "source.ocaml.ocamlbuild",
        "path": "./syntaxes/ocamlbuild.json"
      },
      {
        "language": "ocaml.ocamldoc",
        "scopeName": "source.ocaml.ocamldoc",
        "path": "./syntaxes/ocamldoc.json"
      },
      {
        "language": "ocaml.ocamlformat",
        "scopeName": "source.ocaml.ocamlformat",
        "path": "./syntaxes/ocamlformat.json"
      },
      {
        "language": "ocaml.ocamllex",
        "scopeName": "source.ocaml.ocamllex",
        "path": "./syntaxes/ocamllex.json"
      },
      {
        "scopeName": "source.action.menhir",
        "path": "./syntaxes/menhir-action.json",
        "injectTo": [
          "source.ocaml"
        ]
      },
      {
        "language": "ocaml.menhir",
        "scopeName": "source.ocaml.menhir",
        "path": "./syntaxes/menhir.json",
        "embeddedLanguages": {
          "source.embedded-action.menhir": "source.action.menhir"
        }
      },
      {
        "language": "ocaml.opam",
        "scopeName": "source.ocaml.opam",
        "path": "./syntaxes/opam.json"
      },
      {
        "language": "ocaml.opam-install",
        "scopeName": "source.ocaml.opam-install",
        "path": "./syntaxes/opam-install.json"
      },
      {
        "language": "ocaml.META",
        "scopeName": "source.ocaml.META",
        "path": "./syntaxes/META.json"
      },
      {
        "language": "ocaml.oasis",
        "scopeName": "source.ocaml.oasis",
        "path": "./syntaxes/oasis.json"
      },
      {
        "language": "atd",
        "scopeName": "source.atd",
        "path": "./syntaxes/atd.json"
      },
      {
        "scopeName": "markdown.reason.codeblock",
        "path": "./syntaxes/reason-markdown-codeblock.json",
        "injectTo": [
          "text.html.markdown"
        ],
        "embeddedLanguages": {
          "meta.embedded.block.reason": "reason"
        }
      },
      {
        "language": "reason",
        "scopeName": "source.reason",
        "path": "./syntaxes/reason.json"
      },
      {
        "language": "cram",
        "scopeName": "source.cram",
        "path": "./syntaxes/cram.json"
      }
    ],
    "snippets": [
      {
        "language": "dune",
        "path": "./snippets/dune.json"
      },
      {
        "language": "dune-project",
        "path": "./snippets/dune-project.json"
      },
      {
        "language": "ocaml",
        "path": "./snippets/ocaml.json"
      },
      {
        "language": "ocaml.ocamllex",
        "path": "./snippets/ocamllex.json"
      }
    ],
    "jsonValidation": [
      {
        "fileMatch": "esy.json",
        "url": "https://raw.githubusercontent.com/esy/esy-schema/master/esySchema.json"
      }
    ],
    "customEditors": [
      {
        "viewType": "ast-editor",
        "displayName": "OCaml AST preview",
        "priority": "option",
        "selector": [
          {
            "filenamePattern": "*.ml"
          },
          {
            "filenamePattern": "*.mli"
          }
        ]
      },
      {
        "viewType": "cm-files-editor",
        "displayName": "OCaml Compilation Artifact Viewer",
        "selector": [
          {
            "filenamePattern": "*.cmi"
          },
          {
            "filenamePattern": "*.cmt"
          },
          {
            "filenamePattern": "*.cmti"
          },
          {
            "filenamePattern": "*.cmo"
          },
          {
            "filenamePattern": "*.cma"
          },
          {
            "filenamePattern": "*.cmx"
          },
          {
            "filenamePattern": "*.cmxa"
          },
          {
            "filenamePattern": "*.cmxs"
          },
          {
            "filenamePattern": "*.bc"
          }
        ]
      }
    ]
  }
}


{
  "name": "cobol",
  "displayName": "COBOL",
  "description": "IntelliSense, highlighting, snippets, and code browsing for COBOL and more",
  "version": "9.3.19",
  "publisher": "bitlang",
  "keywords": [
    "acucobol-gt",
    "acucobol",
    "bms",
    "cics",
    "cobol-it",
    "cobol",
    "cobolit",
    "jcl",
    "mfcobol",
    "mfu",
    "multi-root ready",
    "net express",
    "ocds",
    "pl/i",
    "pli",
    "server express",
    "visual cobol"
  ],
  "repository": {
    "type": "git",
    "url": "https://github.com/spgennard/vscode_cobol"
  },
  "bugs": {
    "email": "stephen@gennard.net"
  },
  "engines": {
    "vscode": "^1.76.0"
  },
  "extensionKind": [
    "workspace"
  ],
  "icon": "images/cobol.png",
  "categories": [
    "Programming Languages",
    "Linters",
    "Snippets",
    "Other"
  ],
  "activationEvents": [
    "onStartupFinished",
    "onFileSystem:file",
    "onFileSystem:vscode-vfs",
    "onFileSystem:ssh",
    "onFileSystem:ftp",
    "onFileSystem:sftp",
    "onFileSystem:git",
    "onFileSystem:member",
    "onFileSystem:streamfile",
    "onFileSystem:zip",
    "onLanguage:plaintext",
    "onLanguage:cobol",
    "view:flat-source-view",
    "workspaceContains:bld.bat",
    "workspaceContains:bld.sh",
    "workspaceContains:**/*.cobol",
    "workspaceContains:**/*.cob",
    "workspaceContains:**/*.cbl",
    "workspaceContains:**/*.cpy",
    "workspaceContains:**/*.md",
    "workspaceContains:**/*.jcl"
  ],
  "main": "./dist/extension",
  "browser": "./dist/web/extension-web.js",
  "license": "SEE LICENSE IN LICENSE",
  "homepage": "https://github.com/spgennard/vscode_cobol",
  "author": {
    "name": "Stephen Gennard",
    "email": "stephen@gennard.net"
  },
  "capabilities": {
    "untrustedWorkspaces": {
      "supported": "limited",
      "restrictedConfigurations": [
        "coboleditor.cache_metadata_verbose_messages",
        "coboleditor.cache_metadata_inactivity_timeout",
        "coboleditor.outline",
        "coboleditor.pre_scan_line_limit",
        "coboleditor.linter",
        "coboleditor.linter_mark_as_information",
        "coboleditor.linter_unused_sections",
        "coboleditor.linter_unused_paragraphs",
        "coboleditor.sourceview",
        "coboleditor.sourceview_include_jcl_files",
        "coboleditor.sourceview_include_hlasm_files",
        "coboleditor.sourceview_include_pli_files",
        "coboleditor.sourceview_include_doc_files",
        "coboleditor.sourceview_include_script_files",
        "coboleditor.sourceview_include_object_files",
        "coboleditor.sourceview_include_test_files",
        "coboleditor.mfunit.diagnostic.color",
        "coboleditor.disable_unc_copybooks_directories",
        "coboleditor.intellisense_item_limit",
        "coboleditor.process_metadata_cache_on_start",
        "coboleditor.parse_copybooks_for_references",
        "coboleditor.workspacefolders_order",
        "coboleditor.linter_house_standards",
        "coboleditor.linter_ignore_section_before_entry",
        "coboleditor.linter_house_standards_rules",
        "coboleditor.linter_ignore_missing_copybook",
        "coboleditor.scan_comments_for_hints",
        "coboleditor.scan_comment_copybook_token",
        "coboleditor.fileformat_strategy",
        "coboleditor.fileformat",
        "coboleditor.format_on_return",
        "coboleditor.format_constants_to_uppercase",
        "coboleditor.metadata_symbols",
        "coboleditor.metadata_entrypoints",
        "coboleditor.metadata_types",
        "coboleditor.metadata_files",
        "coboleditor.metadata_knowncopybooks",
        "coboleditor.maintain_metadata_cache",
        "coboleditor.maintain_metadata_recursive_search",
        "coboleditor.enable_semantic_token_provider",
        "coboleditor.enable_text_replacement",
        "coboleditor.enable_source_scanner",
        "coboleditor.enable_data_provider",
        "jcleditor.margin"
      ]
    }
  },
  "contributes": {
    "configuration": {
      "type": "object",
      "title": "COBOL",
      "properties": {
        "coboleditor.tabstops": {
          "type": "array",
          "items": {
            "type": "number",
            "title": "tabstops",
            "properties": {
              "tabstop": {
                "type": "number",
                "description": "tabstop"
              }
            }
          },
          "default": [
            0,
            7,
            11,
            15,
            19,
            23,
            27,
            31,
            35,
            39,
            43,
            47,
            51,
            55,
            59,
            63,
            67,
            71,
            75,
            79
          ],
          "description": "COBOL tabstops"
        },
        "coboleditor.copybookexts": {
          "type": "array",
          "items": {
            "type": "string",
            "title": "copybookextension",
            "properties": {
              "tabstop": {
                "type": "string",
                "description": "copybookextension"
              }
            }
          },
          "default": [
            "cpy",
            "CPY",
            "scr",
            "SCR",
            "cbl",
            "CBL",
            "ccp",
            "CCP",
            "dds",
            "DDS",
            "ss",
            "SS",
            "wks",
            "WKS",
            "inc",
            "INC",
            "cblcpy",
            "CBLCPY"
          ],
          "markdownDescription": "COBOL CopyBook file name extensions",
          "description": "COBOL CopyBook Extensions",
          "uniqueItems": true
        },
        "coboleditor.program_extensions": {
          "type": "array",
          "items": {
            "type": "string",
            "title": "program_extensions",
            "properties": {
              "tabstop": {
                "type": "string",
                "description": "program_extension"
              }
            }
          },
          "default": [
            "cob",
            "COB",
            "cbl",
            "CBL",
            "cblle",
            "CBLLE",
            "sqlcblle",
            "SQLCBLLE",
            "cobol",
            "COBOL",
            "scbl",
            "SCBL",
            "pco",
            "PCO",
            "eco",
            "ECO",
            "copy",
            "COPY",
            "cobcopy",
            "COBCOPY"
          ],
          "markdownDescription": "COBOL Program file name extensions",
          "description": "COBOL Program Extensions",
          "uniqueItems": true
        },
        "coboleditor.copybookdirs": {
          "type": "array",
          "items": {
            "type": "string",
            "title": "copybookdirs",
            "properties": {
              "tabstop": {
                "type": "string",
                "description": "copybookdir"
              }
            }
          },
          "default": [],
          "description": "COBOL CopyBook directories to search into",
          "uniqueItems": true
        },
        "coboleditor.copybooks_nested": {
          "deprecationMessage": "This setting is depreciated and may be removed in future releases",
          "type": "boolean",
          "markdownDescription": "nest copybooks in outline view (restart required)",
          "description": "nest copybooks in outline view (restart require)",
          "default": false
        },
        "coboleditor.cache_metadata_inactivity_timeout": {
          "type": "number",
          "markdownDescription": "Inactivity timeout for metadata cache in ms",
          "title": "Inactivity timeout for metadata cache in ms",
          "default": 5000
        },
        "coboleditor.enable_data_provider": {
          "type": "boolean",
          "markdownDescription": "Enabled data/field completion provider",
          "title": "Enabled data/field completion provider",
          "default": true
        },
        "coboleditor.cache_metadata_verbose_messages": {
          "type": "boolean",
          "description": "Show log message during meta data processing",
          "default": false
        },
        "jcleditor.margin": {
          "type": "boolean",
          "description": "When enabled, always apply margin shading for JCL source code",
          "markdownDescription": "When enabled, *always* apply margin shading for JCL source code",
          "default": true
        },
        "coboleditor.margin": {
          "type": "boolean",
          "description": "When enabled, always apply margin shading for COBOL source code",
          "markdownDescription": "When enabled, *always* apply margin shading for COBOL source code",
          "default": true
        },
        "coboleditor.fileformat_strategy": {
          "enum": [
            "always_fixed",
            "always_variable",
            "normal"
          ],
          "default": "normal",
          "markdownDescription": "File format strategy",
          "title": "always_fixed, always_variable or normal",
          "enumDescriptions": [
            "Assume source code is fixed source format",
            "Assume source code is variable source format",
            "Determine source code format or configure it with fileformat"
          ]
        },
        "coboleditor.fileformat": {
          "type": "array",
          "markdownDescription": "Default configuration for file format. [Read more...](https://github.com/spgennard/vscode_cobol#coboleditorfileformat)",
          "items": {
            "type": "object",
            "title": "List of properties to match file format",
            "properties": {
              "pattern": {
                "type": "string",
                "description": "Filename or pattern"
              },
              "sourceformat": {
                "type": "string",
                "description": "sourceformat",
                "enum": [
                  "free",
                  "fixed",
                  "variable",
                  "terminal"
                ],
                "enumDescriptions": [
                  "source code format free (no margins",
                  "source code format fixed (classic COBOL margins)",
                  "source code format variable (no right margin)",
                  "source code format terminal (ACU COBOL/RM)"
                ]
              }
            }
          },
          "default": [
            {
              "pattern": "**/FIXED*.cbl",
              "sourceformat": "fixed"
            }
          ],
          "description": "An array of filenames/patterns and its associated source format"
        },
        "coboleditor.enable_tabstop": {
          "type": "boolean",
          "description": "When enabled, activate COBOL tab/detab key",
          "default": true
        },
        "coboleditor.comment_line": {
          "type": "boolean",
          "description": "When enabled, activate COBOL comment key",
          "default": true
        },
        "coboleditor.outline": {
          "markdownDescription": "Configure or disable outline view for COBOL",
          "type": "string",
          "description": "on=everything, partial=no paragraphs, skeleton=basic structure and off",
          "enum": [
            "on",
            "partial",
            "skeleton",
            "off"
          ],
          "enumDescriptions": [
            "Scans everything in the source (can be costly)",
            "Scans everything expect paragraphs",
            "Scans very little but might be enough for basic navigation",
            "No source scanning is done"
          ],
          "default": "on"
        },
        "coboleditor.pre_scan_line_limit": {
          "type": "number",
          "title": "Set pre-scan line limit",
          "description": "Set pre-scan line limit, used to determine if source is COBOL or a CopyBook.",
          "default": 25,
          "minimum": 5,
          "maximum": 255
        },
        "coboleditor.linter": {
          "type": "boolean",
          "description": "When enabled, activate basic linting (limited to sections/paragraph use)",
          "default": false
        },
        "coboleditor.linter_mark_as_information": {
          "type": "boolean",
          "description": "When enabled, mark all linter problems as information (false is hint)",
          "default": true
        },
        "coboleditor.linter_unused_sections": {
          "type": "boolean",
          "description": "When enabled, activate basic linting (limited to sections use)",
          "default": true
        },
        "coboleditor.linter_unused_paragraphs": {
          "type": "boolean",
          "description": "When enabled, activate basic linting (limited to paragraph use)",
          "default": true
        },
        "coboleditor.sourceview": {
          "type": "boolean",
          "description": "Enable explorer source panel view",
          "default": true
        },
        "coboleditor.feedbackview": {
          "type": "boolean",
          "description": "Enable experimental feedback panel view",
          "default": true
        },
        "coboleditor.sourceview_include_jcl_files": {
          "type": "boolean",
          "description": "Include JCL Files in source view",
          "default": true
        },
        "coboleditor.sourceview_include_hlasm_files": {
          "type": "boolean",
          "description": "Include HLASM Files in source view",
          "default": true
        },
        "coboleditor.sourceview_include_pli_files": {
          "type": "boolean",
          "description": "Include PL/I Files in source view",
          "default": true
        },
        "coboleditor.sourceview_include_doc_files": {
          "type": "boolean",
          "description": "Include Documentation Files in source view",
          "default": true
        },
        "coboleditor.sourceview_include_script_files": {
          "type": "boolean",
          "description": "Include Script Files in source view",
          "default": true
        },
        "coboleditor.sourceview_include_object_files": {
          "type": "boolean",
          "description": "Include Object Files in source view",
          "default": true
        },
        "coboleditor.sourceview_include_test_files": {
          "type": "boolean",
          "description": "Include Test Files in source view",
          "default": true
        },
        "coboleditor.line_comment": {
          "type": "boolean",
          "title": "Replace standard comment in/out with COBOL aware version",
          "description": "Replace standard comment in/out with COBOL specific version",
          "default": true
        },
        "coboleditor.mfunit.diagnostic.color": {
          "type": "boolean",
          "description": "Enable ANSI color when using the Micro Focus Unit Testing Framework (mfunit) in terminal",
          "default": true
        },
        "coboleditor.disable_unc_copybooks_directories": {
          "type": "boolean",
          "description": "Disable UNC Copybooks (default false)",
          "default": false
        },
        "coboleditor.intellisense_style": {
          "enum": [
            "unchanged",
            "camelcase",
            "lowercase",
            "uppercase"
          ],
          "default": "unchanged",
          "markdownDescription": "Include results in specific format",
          "title": "Include results in specific format"
        },
        "coboleditor.intellisense_no_space_keywords": {
          "type": "array",
          "description": "A list of keywords that do not require a space afterwards",
          "items": {
            "type": "string"
          },
          "default": [
            "section",
            "end-add",
            "end-call",
            "end-chain",
            "end-compute",
            "end-delete",
            "end-display",
            "end-divide",
            "end-evaluate",
            "end-exec",
            "end-if",
            "end-invoke",
            "end-multiply",
            "end-of-page",
            "end-perform",
            "end-read",
            "end-receive",
            "end-return",
            "end-rewrite",
            "end-search",
            "end-start",
            "end-string",
            "end-subtract",
            "end-unstring",
            "end-write"
          ],
          "uniqueItems": true
        },
        "coboleditor.intellisense_item_limit": {
          "type": "number",
          "title": "Max number of items to return",
          "description": "Max number of items to return (default 120)",
          "default": 120,
          "minItems": 30
        },
        "coboleditor.custom_intellisense_rules": {
          "type": "array",
          "description": "Custom intellisense rules",
          "items": {
            "type": "string",
            "title": "Custom intellisense rule (item:[clu=])",
            "pattern": "(^.*:[clu=]$)",
            "patternErrorMessage": "Invalid custom intellisense rule (item:[clu]) where c=camelcase, u=uppercase, l=lowercase or = unchanged"
          },
          "default": [],
          "uniqueItems": true
        },
        "coboleditor.process_metadata_cache_on_start": {
          "type": "boolean",
          "description": "Process metadata cache on extension load (default false)",
          "default": false
        },
        "coboleditor.parse_copybooks_for_references": {
          "type": "boolean",
          "description": "Scan copybook for reference (default false)",
          "default": false
        },
        "coboleditor.workspacefolders_order": {
          "type": "array",
          "description": "List of ordered workspace folders",
          "items": {
            "type": "string",
            "title": "workspacefolders",
            "properties": {
              "copybook": {
                "type": "string",
                "description": "workspacefolder"
              }
            }
          },
          "default": [],
          "uniqueItems": true
        },
        "coboleditor.linter_house_standards": {
          "type": "boolean",
          "description": "Enable house standards rules",
          "default": false
        },
        "coboleditor.linter_ignore_section_before_entry": {
          "type": "boolean",
          "description": "Do not issue a warning if a unused section occurs before a entry-point, as this is often used to stop code trickling through to the next statements.",
          "default": true
        },
        "coboleditor.linter_house_standards_rules": {
          "type": "array",
          "items": {
            "type": "string",
            "title": "Data division section rules",
            "properties": {
              "copybook": {
                "type": "string",
                "description": "rule (regex)"
              }
            }
          },
          "default": [
            "file=.*",
            "thread-local=.*",
            "working-storage=.*",
            "object-storage=.*",
            "local-storage=.*",
            "linkage=.*",
            "communication=.*",
            "report=.*",
            "screen=.*"
          ],
          "uniqueItems": true
        },
        "coboleditor.linter_ignore_missing_copybook": {
          "type": "boolean",
          "description": "When enabled, do not generate missing copybook warnings",
          "default": false
        },
        "coboleditor.scan_comments_for_hints": {
          "type": "boolean",
          "description": "When enabled, process scanner hints embedded in comments",
          "default": false
        },
        "coboleditor.scan_comment_copybook_token": {
          "type": "string",
          "description": "Comment token used for processing source code dependencies, for example extra copybooks",
          "default": "source-dependency"
        },
        "coboleditor.format_on_return": {
          "type": "boolean",
          "default": "false",
          "markdownDescription": "Format line on return key",
          "title": "Format line on return key"
        },
        "coboleditor.format_constants_to_uppercase": {
          "type": "boolean",
          "description": "When enabled, ensures all constants are folded to uppercase (when field formatting is actioned)",
          "default": true
        },
        "coboleditor.metadata_symbols": {
          "type": "array",
          "items": {
            "type": "string",
            "title": "callablesymbol",
            "properties": {
              "copybook": {
                "type": "string",
                "description": "internal metadata symbol"
              }
            }
          },
          "default": [],
          "uniqueItems": true
        },
        "coboleditor.metadata_entrypoints": {
          "type": "array",
          "items": {
            "type": "string",
            "title": "entypoints",
            "properties": {
              "copybook": {
                "type": "string",
                "description": "internal metadata entypoints"
              }
            },
            "readOnly": true
          },
          "default": [],
          "uniqueItems": true
        },
        "coboleditor.metadata_types": {
          "type": "array",
          "items": {
            "type": "string",
            "title": "types",
            "properties": {
              "copybook": {
                "type": "string",
                "description": "internal metadata entypoints"
              }
            }
          },
          "default": [],
          "uniqueItems": true
        },
        "coboleditor.metadata_files": {
          "type": "array",
          "items": {
            "type": "string",
            "title": "types",
            "properties": {
              "copybook": {
                "type": "string",
                "description": "internal metadata files"
              }
            }
          },
          "default": [],
          "uniqueItems": true
        },
        "coboleditor.metadata_knowncopybooks": {
          "type": "array",
          "items": {
            "type": "string",
            "title": "types",
            "properties": {
              "copybook": {
                "type": "string",
                "description": "internal metadata copybook filenames"
              }
            }
          },
          "default": [],
          "uniqueItems": true
        },
        "coboleditor.maintain_metadata_cache": {
          "type": "boolean",
          "description": "Maintain Metadata Cache",
          "default": true
        },
        "coboleditor.maintain_metadata_recursive_search": {
          "type": "boolean",
          "description": "When 'Maintain Metadata Cache' is enabled, recursive search for source code filenames/copybooks",
          "default": false
        },
        "coboleditor.enable_semantic_token_provider": {
          "type": "boolean",
          "description": "When enabled, turn on the semantic token provider",
          "default": false
        },
        "coboleditor.enable_text_replacement": {
          "type": "boolean",
          "description": "Process 'replace' and 'replacing' verb (default false)",
          "default": false
        },
        "coboleditor.enable_source_scanner": {
          "type": "boolean",
          "description": "Scan source code (default true)",
          "default": true
        },
        "coboleditor.valid_cobol_language_ids": {
          "type": "array",
          "description": "Valid Visual Studio COBOL Language Id",
          "items": {
            "type": "string",
            "title": "Valid Visual Studio COBOL Language Id",
            "pattern": "(^cobol$|^COBOL$|^COBOLIT$|^ACUCOBOL$|^COBOL_MF_LISTFILE|^BITLANG-COBOL$)",
            "patternErrorMessage": "Invalid language id, can be cobol, COBOL, COBOLIT, ACUCOBOL or COBOL_MF_LISTFILE"
          },
          "default": [
            "COBOL",
            "BITLANG-COBOL",
            "COBOLIT",
            "ACUCOBOL"
          ],
          "uniqueItems": true
        },
        "coboleditor.xedit_keymap": {
          "type": "boolean",
          "description": "Enable 'xedit' key mapping",
          "default": false
        },
        "coboleditor.files_exclude": {
          "description": "list of files to exclude from source scanning, it can be used to avoid 'unresponsive' messages",
          "type": "array",
          "items": {
            "type": "string",
            "format": "regex",
            "description": "list of files to exclude from source scanning, it can be used to avoid 'unresponsive' messages"
          },
          "uniqueItems": true
        },
        "coboleditor.scan_line_limit": {
          "type": "number",
          "title": "Set source scanner line limit",
          "description": "Set source scanner line limit, it can be used to avoid 'unresponsive' messages",
          "default": 20000,
          "minimum": 255
        },
        "coboleditor.scan_time_limit": {
          "type": "number",
          "title": "Set scan time limit in ms",
          "description": "Set scan time limit, it can be used to avoid 'unresponsive' messages",
          "default": 4000,
          "minimum": 500
        },
        "coboleditor.in_memory_cache_size": {
          "type": "number",
          "title": "Size of internal memory cache",
          "description": "Size of internal memory cache for scanned source code",
          "default": 6,
          "minimum": 2,
          "maximum": 24
        },
        "coboleditor.suggest_variables_when_context_is_unknown": {
          "type": "boolean",
          "title": "Suggest variables when context is unknown",
          "description": "Suggest variables when context for a verb is unknown",
          "default": true
        },
        "coboleditor.hover_show_known_api": {
          "title": "Show description of known api during 'hover'",
          "markdownDescription": "Show a short description of known apis when hovered on.  Known apis include 'Micro Focus Library apis' and some ILE apis.",
          "enum": [
            "off",
            "short",
            "long"
          ],
          "default": "short",
          "enumDescriptions": [
            "Off",
            "Short message (description & link)",
            "Longer message (description, link & example)"
          ]
        },
        "coboleditor.enable_comment_tags": {
          "type": "boolean",
          "description": "Enable coloured comments",
          "default": false
        },
        "coboleditor.comment_tag_word": {
          "type": "boolean",
          "description": "Colourise the tag only",
          "default": false
        },
        "coboleditor.comments_tags": {
          "type": "array",
          "description": "Tags which are used to color the comments.",
          "items": {
            "title": "Comment tag",
            "type": "object",
            "properties": {
              "tag": {
                "type": "string"
              },
              "color": {
                "type": "string",
                "format": "color"
              },
              "strikethrough": {
                "type": "boolean"
              },
              "underline": {
                "type": "boolean"
              },
              "backgroundColor": {
                "type": "string",
                "format": "color"
              },
              "bold": {
                "type": "boolean"
              },
              "italic": {
                "type": "boolean"
              }
            }
          },
          "default": [
            {
              "tag": "!",
              "color": "#FF2D00",
              "strikethrough": false,
              "underline": false,
              "backgroundColor": "transparent",
              "bold": false,
              "italic": false
            },
            {
              "tag": "?",
              "color": "#3498DB",
              "strikethrough": false,
              "underline": false,
              "backgroundColor": "transparent",
              "bold": false,
              "italic": false
            },
            {
              "tag": "todo",
              "color": "#FF8C00",
              "strikethrough": false,
              "underline": false,
              "backgroundColor": "transparent",
              "bold": false,
              "italic": false
            },
            {
              "tag": "* ",
              "color": "#98C379",
              "strikethrough": false,
              "underline": false,
              "backgroundColor": "transparent",
              "bold": false,
              "italic": false
            },
            {
              "tag": "//",
              "color": "#474747",
              "strikethrough": true,
              "underline": false,
              "backgroundColor": "transparent",
              "bold": false,
              "italic": false
            },
            {
              "tag": "note",
              "color": "#FF8C00",
              "strikethrough": false,
              "underline": false,
              "backgroundColor": "transparent",
              "bold": false,
              "italic": false,
              "reverse": true
            }
          ]
        },
        "coboleditor.snippets": {
          "type": "boolean",
          "description": "Dynamic snippets support (expect this property to renamed/removed, when feature is complete)",
          "default": true
        },
        "coboleditor.enable_columns_tags": {
          "type": "boolean",
          "description": "Enable coloured margin",
          "default": false
        },
        "coboleditor.columns_tags": {
          "type": "array",
          "description": "Tags which are used to color the margins.",
          "deprecationMessage": "This feature is not enabled.. this message will be removed when it is...",
          "items": {
            "title": "Margin tag",
            "type": "object",
            "properties": {
              "tag": {
                "type": "string"
              },
              "color": {
                "type": "string",
                "format": "color"
              },
              "strikethrough": {
                "type": "boolean"
              },
              "underline": {
                "type": "boolean"
              },
              "backgroundColor": {
                "type": "string",
                "format": "color"
              },
              "bold": {
                "type": "boolean"
              },
              "italic": {
                "type": "boolean"
              }
            }
          },
          "default": [
            {
              "tag": "todo",
              "color": "#FF8C00",
              "strikethrough": false,
              "underline": false,
              "backgroundColor": "transparent",
              "bold": false,
              "italic": false
            }
          ]
        },
        "coboleditor.enable_tab_next_or_previous": {
          "type": "boolean",
          "description": "When enabled, allow tab to be used for 'next'/'previous' suggestions",
          "default": true
        },
        "coboleditor.enable_tab_inline": {
          "type": "boolean",
          "description": "When enabled, allow tab to be used for inline suggestions",
          "default": true
        },
        "coboleditor.hover_show_encoded_literals": {
          "type": "boolean",
          "description": "When enabled, decode hex literals when hover over them",
          "default": true
        },
        "coboleditor.check_file_format_before_file_scan": {
          "type": "boolean",
          "description": "When enabled, process coboleditor.fileformat before scanning the file",
          "default": true
        },
        "coboleditor.template_microfocus": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "default": [
            "       program-id. ${1:${TM_FILENAME/(.*)\\..+$/$1/}}.",
            "",
            "       environment division.",
            "       configuration section.",
            "",
            "       data division.",
            "       working-storage section.",
            "       linkage section.",
            "",
            "       procedure division.",
            "           $0",
            "           goback.",
            "",
            "       end program $1.",
            ""
          ],
          "description": "Template for a minimum 'Micro Focus' COBOL program"
        },
        "coboleditor.template_microfocus_mfunit": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "default": [
            "       copy \"mfunit_prototypes.cpy\".",
            "",
            "       identification division.",
            "       program-id. Test${1:${TM_FILENAME_BASE/Test(.*)/$1/}}.",
            "",
            "       data division.",
            "       working-storage section.",
            "       78 TEST-Program value \"${1}\".",
            "       copy \"mfunit.cpy\".",
            "       78 TEST-PRELOAD-LIBRARY value \"${3}\".",
            "       01 TEST-PP              procedure-pointer.",
            "",
            "       *> Testcase     : $1",
            "       *>  Description : ${2:The description of the test case}",
            "       procedure division.",
            "           goback returning 0",
            "       .",
            "",
            "       entry MFU-TC-PREFIX & TEST-${1}.",
            "      *> Test code goes here.",
            "           $0",
            "           goback returning MFU-PASS-RETURN-CODE",
            "       .",
            "",
            "      \\$region Test Configuration",
            "      *> Setup Code:",
            "       entry MFU-TC-SETUP-PREFIX & TEST-${1}.",
            "           perform InitializeLinkageData",
            "",
            "           *> Add any other test setup code here",
            "           goback returning 0",
            "       .",
            "",
            "      *> Teardown Code:",
            "       entry MFU-TC-TEARDOWN-PREFIX & TEST-${1}.",
            "           goback returning 0",
            "       .",
            "",
            "      *> Metadata:",
            "       entry MFU-TC-METADATA-SETUP-PREFIX & TEST-${1}.",
            "           move \"${2}\" to MFU-MD-TESTCASE-DESCRIPTION",
            "           move ${4:100000} to MFU-MD-TIMEOUT-IN-MS",
            "           move \"${5:smoke,regression,sanity,interface,other}\" to MFU-MD-TRAITS",
            "           set MFU-MD-SKIP-TESTCASE to False",
            "           goback returning 0",
            "       .",
            "",
            "       InitializeLinkageData section.",
            "           if TEST-PRELOAD-LIBRARY not equal spaces",
            "      *> Load the library that is being tested",
            "               set TEST-PP to entry TEST-PRELOAD-LIBRARY",
            "           end-if",
            "           exit section",
            "       .",
            "      \\$end-region",
            "",
            "       end program Test${1}."
          ]
        },
        "coboleditor.template_acucobol": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "default": [
            "       Identification Division.",
            "       Program-Id. ${1:${TM_FILENAME/(.*)\\..+$/$1/}}.",
            "       Data Division.",
            "       Working-Storage Section.",
            "       Procedure Division.",
            "           $0",
            "           GoBack.",
            "       End Program $1."
          ]
        },
        "coboleditor.enable_codelens_variable_references": {
          "type": "boolean",
          "description": "When enabled, turn on codelens for variable references",
          "default": false
        },
        "coboleditor.enable_codelens_section_paragraph_references": {
          "type": "boolean",
          "description": "When enabled, turn on codelens for sections/paragraphs references",
          "default": false
        },
        "coboleditor.enable_codelens_copy_replacing": {
          "type": "boolean",
          "description": "When enabled, turn on codelens for simple copy replacing",
          "default": false
        },
        "coboleditor.enable_closeEditorsToTheLeft": {
          "type": "boolean",
          "description": "When enabled, close editor close tabs to left context menu",
          "default": true
        }
      }
    },
    "breakpoints": [
      {
        "language": "COBOL"
      },
      {
        "language": "BITLANG-COBOL"
      },
      {
        "language": "ACUCOBOL"
      }
    ],
    "views": {
      "explorer": [
        {
          "id": "flat-source-view",
          "name": "Source View",
          "when": "config.coboleditor.sourceview"
        },
        {
          "id": "help-and-feedback-view",
          "name": "Help on COBOL and Feedback",
          "when": "config.coboleditor.feedbackview"
        }
      ]
    },
    "configurationDefaults": {
      "workbench.editor.untitled.labelFormat": "name",
      "explorer.fileNesting.patterns": {
        "*.ts": "${capture}.js",
        "*.js": "${capture}.js.map, ${capture}.min.js, ${capture}.d.ts",
        "*.jsx": "${capture}.js",
        "*.tsx": "${capture}.ts",
        "tsconfig.json": "tsconfig.*.json",
        "package.json": "package-lock.json, yarn.lock",
        "*.cbl": "MFU*$(basename).cpy,Test$(basename).cpy",
        "*.CBL": "MFU*$(basename).cpy,Test$(basename).cpy",
        "*.cob": "MFU*$(basename).cpy,Test$(basename).cpy",
        "*.COB": "MFU*$(basename).cpy,Test$(basename).cpy"
      },
      "[COBOL]": {
        "editor.semanticHighlighting.enabled": true,
        "editor.bracketPairColorization.enabled": false,
        "files.autoGuessEncoding": false,
        "editor.snippetSuggestions": "bottom",
        "editor.guides.indentation": false,
        "editor.autoIndent": "advanced",
        "editor.insertSpaces": true,
        "editor.formatOnType": true,
        "editor.rulers": [
          6,
          7,
          11,
          72
        ],
        "editor.detectIndentation": false,
        "editor.useTabStops": false,
        "editor.wordSeparators": "`~!@$%^&*()=+[{]}\\|;:'\",.<>/?"
      },
      "[BITLANG-COBOL]": {
        "editor.semanticHighlighting.enabled": true,
        "editor.bracketPairColorization.enabled": false,
        "files.autoGuessEncoding": false,
        "editor.snippetSuggestions": "bottom",
        "editor.guides.indentation": false,
        "editor.autoIndent": "advanced",
        "editor.insertSpaces": true,
        "editor.formatOnType": true,
        "editor.rulers": [
          6,
          7,
          11,
          72
        ],
        "editor.detectIndentation": false,
        "editor.useTabStops": false,
        "editor.wordSeparators": "`~!@$%^&*()=+[{]}\\|;:'\",.<>/?"
      },
      "[ACUCOBOL]": {
        "editor.semanticHighlighting.enabled": true,
        "editor.bracketPairColorization.enabled": false,
        "editor.insertSpaces": true,
        "editor.guides.indentation": false,
        "files.autoGuessEncoding": false,
        "editor.autoIndent": "full",
        "editor.formatOnType": false,
        "editor.rulers": [
          6,
          7,
          72
        ],
        "editor.detectIndentation": false,
        "editor.wordSeparators": "`~!#$%^&*()=+[{]}\\|;:'\",.<>/?"
      },
      "[dir]": {
        "editor.semanticHighlighting.enabled": false,
        "editor.insertSpaces": true,
        "editor.guides.indentation": false,
        "files.autoGuessEncoding": false,
        "editor.autoIndent": "keep",
        "editor.formatOnType": false,
        "editor.rulers": [],
        "editor.detectIndentation": false,
        "editor.wordSeparators": "`~!@#$%^&*()=[{]}\\|;:'\",<>/?"
      },
      "[JCL]": {
        "editor.semanticHighlighting.enabled": false,
        "files.autoGuessEncoding": false,
        "editor.guides.indentation": false,
        "editor.detectIndentation": false,
        "editor.formatOnType": false,
        "editor.autoIndent": "full",
        "editor.rulers": [
          71,
          72,
          80
        ]
      },
      "[hlasm]": {
        "editor.semanticHighlighting.enabled": false,
        "editor.rulers": [
          0,
          9,
          15,
          71,
          72,
          80
        ],
        "editor.guides.indentation": false
      },
      "[sql]": {
        "editor.wordSeparators": "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?"
      }
    },
    "languages": [
      {
        "id": "ACUCOBOL",
        "aliases": [
          "ACUCOBOL",
          "acucobol"
        ],
        "firstLine": "^      \\*(.*\\.[sS][cC][rR]|.[Bb]ench.).*$",
        "extensions": [
          ".evt",
          ".lks",
          ".prd",
          ".wrk",
          ".mnu",
          ".def",
          ".sl",
          ".EVT",
          ".LKS",
          ".PRD",
          ".WRK",
          ".MNU",
          ".DEF",
          ".SL"
        ],
        "configuration": "./acucobol.configuration.json"
      },
      {
        "id": "markdown-acucobol-injection"
      },
      {
        "id": "COBOL",
        "filenames": [
          "SQLCA"
        ],
        "firstLine": ".*(\\$[sS][eE][tT]|[pP][rR][oO][gG][rR][aA][mM]\\-[iI][dD]|[iI][dD][eE][nN][tT][iI][fF][iI][cC][aA][tT][iI][oO][nN]|\\*.[mM][iI][cC][rR][oO]).*",
        "extensions": [
          ".cbl",
          ".cobol",
          ".cblle",
          ".cblsrce",
          ".cblcpy",
          ".pdv",
          ".cpy",
          ".copybook",
          ".cobcopy",
          ".fd",
          ".sel",
          ".scb",
          ".spb",
          ".scbl",
          ".sqlcblle",
          ".cob",
          ".dds",
          ".def",
          ".src",
          ".ss",
          ".wks",
          ".bib",
          ".pco",
          ".eco",
          ".COBOL",
          ".CBL",
          ".CBLLE",
          ".CBLSRCE",
          ".CBLCPY",
          ".PDV",
          ".CPY",
          ".COPYBOOK",
          ".COBCOPY",
          ".FD",
          ".SEL",
          ".SCB",
          ".SPB",
          ".SCBL",
          ".SQLCBLLE",
          ".COB",
          ".DDS",
          ".DEF",
          ".SRC",
          ".SS",
          ".WKS",
          ".BIB",
          ".PCO",
          ".ECO"
        ],
        "configuration": "./cobol.configuration.json"
      },
      {
        "id": "markdown-cobol-injection"
      },
      {
        "id": "BITLANG-COBOL",
        "filenames": [
          "SQLCA"
        ],
        "firstLine": ".*(\\$[sS][eE][tT]|[pP][rR][oO][gG][rR][aA][mM]\\-[iI][dD]|[iI][dD][eE][nN][tT][iI][fF][iI][cC][aA][tT][iI][oO][nN]|\\*.[mM][iI][cC][rR][oO]).*",
        "extensions": [],
        "configuration": "./cobol.configuration.json"
      },
      {
        "id": "COBOL_MF_LISTFILE",
        "extensions": [],
        "configuration": "./cobol.configuration.json"
      },
      {
        "id": "COBOL_PCOB_LISTFILE",
        "extensions": [],
        "configuration": "./cobol.configuration.json"
      },
      {
        "id": "COBOL_ACU_LISTFILE",
        "extensions": [],
        "configuration": "./cobol.configuration.json"
      },
      {
        "id": "COBOL_MF_PREP",
        "extensions": [
          ".prep"
        ],
        "configuration": "./cobol.configuration.json"
      },
      {
        "id": "COBOLIT",
        "extensions": [],
        "configuration": "./cobolit.configuration.json"
      },
      {
        "id": "markdown-cobolit-injection"
      },
      {
        "id": "JCL",
        "extensions": [
          ".jcl",
          ".job",
          ".cntl",
          ".prc",
          ".proc"
        ],
        "configuration": "./jcl.configuration.json"
      },
      {
        "id": "jcl",
        "extensions": [
          ".jcl",
          ".job",
          ".cntl",
          ".prc",
          ".proc"
        ],
        "configuration": "./jcl.configuration.json"
      },
      {
        "id": "markdown-jcl-injection"
      },
      {
        "id": "mfupp_dir",
        "aliases": [
          "MFUPP_DIR"
        ],
        "filenames": [
          "mfupp.dir"
        ],
        "configuration": "./mfupp_dir-configuration.json"
      },
      {
        "id": "xml",
        "extensions": [
          ".cblproj"
        ]
      },
      {
        "id": "dir",
        "extensions": [
          ".dir"
        ],
        "aliases": [
          "dirfile",
          "dir"
        ],
        "configuration": "./dir.configuration.json"
      },
      {
        "id": "pli",
        "extensions": [
          ".pl1",
          ".pli",
          ".plinc",
          ".pc",
          ".pci",
          ".pcx",
          ".inc"
        ],
        "configuration": "./pli.configuration.json"
      },
      {
        "id": "markdown-pli-injection"
      },
      {
        "id": "bms",
        "extensions": [
          ".bms"
        ],
        "aliases": []
      },
      {
        "id": "bmsmap",
        "extensions": [],
        "aliases": []
      },
      {
        "id": "hlasm",
        "extensions": [
          ".hlasm",
          ".asm",
          ".mac",
          ".mlc"
        ],
        "aliases": []
      },
      {
        "id": "markdown-hlasm-injection"
      },
      {
        "id": "mfu",
        "aliases": [
          "mfunit"
        ],
        "extensions": [
          "mfu"
        ],
        "configuration": "./mfu-configuration.json"
      },
      {
        "id": "utreport",
        "aliases": [
          "Unit Test Report"
        ],
        "filenamePatterns": [
          "*-report.txt"
        ],
        "configuration": "./utreport-configuration.json"
      },
      {
        "id": "xml",
        "extensions": [
          ".cblproj"
        ]
      }
    ],
    "grammars": [
      {
        "language": "COBOL",
        "scopeName": "source.cobol",
        "path": "./syntaxes/COBOL.tmLanguage.json",
        "embeddedLanguages": {
          "meta.embedded.block.sql": "sql",
          "meta.embedded.block.html": "html",
          "meta.embedded.block.java": "java"
        }
      },
      {
        "language": "markdown-cobol-injection",
        "scopeName": "markdown.cobol.codeblock",
        "path": "./syntaxes/markdown/cobol.json",
        "injectTo": [
          "text.html.markdown"
        ],
        "embeddedLanguages": {
          "meta.embedded.block.cobol": "COBOL"
        }
      },
      {
        "language": "BITLANG-COBOL",
        "scopeName": "source.cobol",
        "path": "./syntaxes/COBOL.tmLanguage.json",
        "embeddedLanguages": {
          "meta.embedded.block.sql": "sql",
          "meta.embedded.block.html": "html",
          "meta.embedded.block.java": "java"
        }
      },
      {
        "language": "COBOL_MF_LISTFILE",
        "scopeName": "source.cobol_mf_listfile",
        "path": "./syntaxes/COBOL_mf_listfile.tmLanguage.json",
        "embeddedLanguages": {
          "meta.embedded.block.sql": "sql",
          "meta.embedded.block.html": "html"
        }
      },
      {
        "language": "COBOL_MF_PREP",
        "scopeName": "source.cobol_mfprep",
        "path": "./syntaxes/COBOL_mfprep.tmLanguage.json",
        "embeddedLanguages": {
          "meta.embedded.block.sql": "sql",
          "meta.embedded.block.html": "html"
        }
      },
      {
        "language": "COBOL_ACU_LISTFILE",
        "scopeName": "source.cobol_acu_listfile",
        "path": "./syntaxes/COBOL_acu_listfile.tmLanguage.json",
        "embeddedLanguages": {
          "meta.embedded.block.sql": "sql",
          "meta.embedded.block.html": "html"
        }
      },
      {
        "language": "COBOL_PCOB_LISTFILE",
        "scopeName": "source.cobol_pcob_listfile",
        "path": "./syntaxes/COBOL_pcob_listfile.tmLanguage.json",
        "embeddedLanguages": {
          "meta.embedded.block.sql": "sql",
          "meta.embedded.block.html": "html"
        }
      },
      {
        "language": "ACUCOBOL",
        "scopeName": "source.acucobol",
        "path": "./syntaxes/ACUCOBOL.tmLanguage.json",
        "embeddedLanguages": {
          "meta.embedded.block.sql": "sql",
          "meta.embedded.block.html": "html"
        }
      },
      {
        "language": "markdown-acucobol-injection",
        "scopeName": "markdown.acucobol.codeblock",
        "path": "./syntaxes/markdown/acucobol.json",
        "injectTo": [
          "text.html.markdown"
        ],
        "embeddedLanguages": {
          "meta.embedded.block.acucobol": "acucobol"
        }
      },
      {
        "language": "COBOLIT",
        "scopeName": "source.cobolit",
        "path": "./syntaxes/COBOLIT.tmLanguage.json",
        "embeddedLanguages": {
          "meta.embedded.block.sql": "text",
          "meta.embedded.block.html": "text",
          "meta.embedded.block.java": "text"
        }
      },
      {
        "language": "markdown-cobolit-injection",
        "scopeName": "markdown.cobolit.codeblock",
        "path": "./syntaxes/markdown/cobolit.json",
        "injectTo": [
          "text.html.markdown"
        ],
        "embeddedLanguages": {
          "meta.embedded.block.cobolit": "cobolit"
        }
      },
      {
        "language": "JCL",
        "scopeName": "source.jcl",
        "path": "./syntaxes/jcl.tmLanguage.json"
      },
      {
        "language": "jcl",
        "scopeName": "source.jcl",
        "path": "./syntaxes/jcl.tmLanguage.json"
      },
      {
        "language": "markdown-jcl-injection",
        "scopeName": "markdown.jcl.codeblock",
        "path": "./syntaxes/markdown/jcl.json",
        "injectTo": [
          "text.html.markdown"
        ],
        "embeddedLanguages": {
          "meta.embedded.block.jcl": "jcl"
        }
      },
      {
        "language": "mfupp_dir",
        "scopeName": "source.mfupp_dir",
        "path": "./syntaxes/mfupp_dir.json"
      },
      {
        "language": "dir",
        "scopeName": "source.dir",
        "path": "./syntaxes/dir.tmLanguage.json"
      },
      {
        "language": "pli",
        "scopeName": "source.pli",
        "path": "./syntaxes/PLI.tmLanguage.json"
      },
      {
        "language": "markdown-pli-injection",
        "scopeName": "markdown.pli.codeblock",
        "path": "./syntaxes/markdown/pli.json",
        "injectTo": [
          "text.html.markdown"
        ],
        "embeddedLanguages": {
          "meta.embedded.block.pli": "pli"
        }
      },
      {
        "language": "bms",
        "scopeName": "source.bms",
        "path": "./syntaxes/bms.tmLanguage.json"
      },
      {
        "language": "bmsmap",
        "scopeName": "source.bmsmap",
        "path": "./syntaxes/bmsmap.tmLanguage.json"
      },
      {
        "language": "hlasm",
        "scopeName": "source.hlasm",
        "path": "./syntaxes/hlasm.tmLanguage.json"
      },
      {
        "language": "markdown-hlasm-injection",
        "scopeName": "markdown.hlasm.codeblock",
        "path": "./syntaxes/markdown/hlasm.json",
        "injectTo": [
          "text.html.markdown"
        ],
        "embeddedLanguages": {
          "meta.embedded.block.hlasm": "hlasm"
        }
      },
      {
        "language": "mfu",
        "scopeName": "source.mfu",
        "path": "./syntaxes/mfu.tmLanguage.json"
      },
      {
        "language": "utreport",
        "scopeName": "source.utreport",
        "path": "./syntaxes/utreport.tmLanguage.json"
      }
    ],
    "commands": [
      {
        "command": "cobolplugin.move2pd",
        "category": "COBOL",
        "title": "Go to Procedure Division",
        "enablement": "editorFocus"
      },
      {
        "command": "cobolplugin.move2ws",
        "category": "COBOL",
        "title": "Go to Working-Storage Section",
        "enablement": "editorFocus"
      },
      {
        "command": "cobolplugin.move2dd",
        "category": "COBOL",
        "title": "Go to Data Division",
        "enablement": "editorFocus"
      },
      {
        "command": "cobolplugin.move2anyforward",
        "category": "COBOL",
        "title": "Go to next Section/Division",
        "enablement": "editorFocus"
      },
      {
        "command": "cobolplugin.move2anybackwards",
        "category": "COBOL",
        "title": "Move to Previous Section/Division",
        "enablement": "editorFocus"
      },
      {
        "command": "cobolplugin.tab",
        "category": "COBOL",
        "title": "Insert a tab",
        "enablement": "editorFocus && config.coboleditor.enable_tabstop"
      },
      {
        "command": "cobolplugin.revtab",
        "category": "COBOL",
        "title": "Remove a tab",
        "enablement": "editorFocus && config.coboleditor.enable_tabstop"
      },
      {
        "command": "cobolplugin.commentline",
        "category": "COBOL",
        "title": "Comment line",
        "enablement": "editorFocus && config.coboleditor.line_comment"
      },
      {
        "command": "cobolplugin.change_lang_to_acu",
        "category": "COBOL",
        "title": "Select ACUCOBOL-GT language"
      },
      {
        "command": "cobolplugin.change_lang_to_cobol",
        "category": "COBOL",
        "title": "Select COBOL language"
      },
      {
        "command": "cobolplugin.clearGlobalCache",
        "category": "COBOL",
        "title": "Clear metadata",
        "enablement": "!isWeb && config.coboleditor.maintain_metadata_cache && isWorkspaceTrusted"
      },
      {
        "command": "cobolplugin.processAllFilesInWorkspace",
        "category": "COBOL",
        "title": "Scan source files in workspace for metadata",
        "enablement": "!isWeb && config.coboleditor.maintain_metadata_cache && isWorkspaceTrusted"
      },
      {
        "command": "cobolplugin.explorerRun",
        "category": "COBOL",
        "title": "Run UnitTest",
        "enablement": "!isWeb && filesExplorerFocus && isWorkspaceTrusted"
      },
      {
        "command": "cobolplugin.explorerDebug",
        "category": "COBOL",
        "title": "Debug",
        "enablement": "!isWeb && filesExplorerFocus && isWorkspaceTrusted"
      },
      {
        "command": "cobolplugin.runCommand",
        "category": "COBOL",
        "title": "Run Without Debugging",
        "enablement": "!isWeb && config.coboleditor.sourceview && !editorFocus && focusedView == flat-source-view && isWorkspaceTrusted"
      },
      {
        "command": "cobolplugin.runDebugCommand",
        "category": "COBOL",
        "title": "Start Debugging",
        "enablement": "!isWeb && config.coboleditor.sourceview && !editorFocus && focusedView == flat-source-view && isWorkspaceTrusted"
      },
      {
        "command": "cobolplugin.removeAllComments",
        "category": "COBOL",
        "title": "Remove COBOL Comments"
      },
      {
        "command": "cobolplugin.removeIdentificationArea",
        "category": "COBOL",
        "title": "Remove COBOL Identification Area"
      },
      {
        "command": "cobolplugin.removeColumnNumbers",
        "category": "COBOL",
        "title": "Remove Column Numbers"
      },
      {
        "command": "cobolplugin.resequenceColumnNumbers",
        "category": "COBOL",
        "title": "Re-sequence Column Numbers"
      },
      {
        "command": "cobolplugin.makeKeywordsLowercase",
        "category": "COBOL",
        "title": "Make keywords lowercase"
      },
      {
        "command": "cobolplugin.makeKeywordsUppercase",
        "category": "COBOL",
        "title": "Make keywords uppercase"
      },
      {
        "command": "cobolplugin.makeKeywordsCamelCase",
        "category": "COBOL",
        "title": "Make keywords camelcase"
      },
      {
        "command": "cobolplugin.makeFieldsLowercase",
        "category": "COBOL",
        "title": "Make fields lowercase"
      },
      {
        "command": "cobolplugin.makeFieldsUppercase",
        "category": "COBOL",
        "title": "Make fields uppercase"
      },
      {
        "command": "cobolplugin.makeFieldsCamelCase",
        "category": "COBOL",
        "title": "Make fields camelcase"
      },
      {
        "command": "cobolplugin.makePerformTargetsLowerCase",
        "category": "COBOL",
        "title": "Make perform targets lowercase"
      },
      {
        "command": "cobolplugin.makePerformTargetsUpperCase",
        "category": "COBOL",
        "title": "Make perform targets uppercase"
      },
      {
        "command": "cobolplugin.makePerformTargetsCamelCase",
        "category": "COBOL",
        "title": "Make perform targets camelcase"
      },
      {
        "command": "cobolplugin.extractSelectionToParagraph",
        "category": "COBOL",
        "title": "Extract selection to paragraph",
        "enablement": "!isWeb && editorFocus && isWorkspaceTrusted"
      },
      {
        "command": "cobolplugin.extractSelectionToSection",
        "category": "COBOL",
        "title": "Extract selection to section",
        "enablement": "!isWeb && editorFocus && isWorkspaceTrusted"
      },
      {
        "command": "cobolplugin.extractSelectionToCopybook",
        "category": "COBOL",
        "title": "Extract selection to copybook",
        "enablement": "!isWeb && isWorkspaceTrusted"
      },
      {
        "command": "cobolplugin.migrateCopybooksToWorkspace",
        "category": "COBOL",
        "title": "Migrate copybook settings to workspace (for performance)",
        "enablement": "!isWeb && isWorkspaceTrusted"
      },
      {
        "command": "cobolplugin.showCOBOLChannel",
        "category": "COBOL",
        "title": "Show COBOL Channel"
      },
      {
        "command": "cobolplugin.indentToCursor",
        "category": "COBOL",
        "title": "indent to cursor"
      },
      {
        "command": "cobolplugin.leftAdjustLine",
        "category": "COBOL",
        "title": "left adjust line"
      },
      {
        "command": "cobolplugin.transposeSelection",
        "category": "COBOL",
        "title": "transpose"
      },
      {
        "command": "cobolplugin.alignStorageFirst",
        "category": "COBOL",
        "enablement": "editorTextFocus && editorHasSelection && cobolplugin.enableStorageAlign",
        "title": "Align to first"
      },
      {
        "command": "cobolplugin.alignStorageLeft",
        "category": "COBOL",
        "enablement": "editorTextFocus && editorHasSelection && cobolplugin.enableStorageAlign",
        "title": "Align to left"
      },
      {
        "command": "cobolplugin.alignStorageCenter",
        "category": "COBOL",
        "enablement": "editorTextFocus && editorHasSelection && cobolplugin.enableStorageAlign",
        "title": "Align to center"
      },
      {
        "command": "cobolplugin.alignStorageRight",
        "category": "COBOL",
        "enablement": "editorTextFocus && editorHasSelection && cobolplugin.enableStorageAlign",
        "title": "Align to right"
      },
      {
        "command": "cobolplugin.padTo72",
        "category": "COBOL",
        "title": "Pad line to column 72"
      },
      {
        "command": "cobolplugin.enforceFileExtensions",
        "category": "COBOL",
        "title": "Enforce extension via file.assocations"
      },
      {
        "command": "cobolplugin.selectionToCOBOLHEX",
        "category": "COBOL",
        "title": "Convert to HEX (X\"..\")"
      },
      {
        "command": "cobolplugin.selectionToHEX",
        "category": "COBOL",
        "title": "Convert to HEX"
      },
      {
        "command": "cobolplugin.selectionHEXToASCII",
        "category": "COBOL",
        "title": "Convert HEX to ASCII"
      },
      {
        "command": "cobolplugin.selectionToCOBOLNXHEX",
        "category": "COBOL",
        "title": "Convert to HEX (NX\"..\") (UTF16)"
      },
      {
        "command": "cobolplugin.selectionToNXHEX",
        "category": "COBOL",
        "title": "Convert to HEX (UTF16)"
      },
      {
        "command": "cobolplugin.newFile_MicroFocus",
        "category": "COBOL",
        "title": "New COBOL Program (Micro Focus)"
      },
      {
        "command": "cobolplugin.newFile_MicroFocus_mfunit",
        "category": "COBOL",
        "title": "New COBOL Unit Test Program (Micro Focus)"
      },
      {
        "command": "cobolplugin.newFile_ACUCOBOL",
        "category": "COBOL",
        "title": "New ACUCOBOL Program (Micro Focus)"
      },
      {
        "command": "cobolplugin.dumpAllSymbols",
        "category": "COBOL",
        "title": "Diagnostic: Dump All Symbol"
      },
      {
        "command": "workbench.action.closeEditorsToTheLeft",
        "title": "Close to the Left",
        "enablement": "config.coboleditor.enable_closeEditorsToTheLeft && !activeEditorIsFirstInGroup"
      }
    ],
    "menus": {
      "file/newFile": [
        {
          "command": "cobolplugin.newFile_MicroFocus"
        },
        {
          "command": "cobolplugin.newFile_MicroFocus_mfunit"
        },
        {
          "command": "cobolplugin.newFile_ACUCOBOL"
        }
      ],
      "editor/context": [
        {
          "command": "cobolplugin.move2dd",
          "group": "navigation_cobol",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !editorHasSelection"
        },
        {
          "command": "cobolplugin.move2ws",
          "group": "navigation_cobol",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !editorHasSelection"
        },
        {
          "command": "cobolplugin.move2pd",
          "group": "navigation_cobol",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !editorHasSelection"
        },
        {
          "command": "cobolplugin.move2anyforward",
          "group": "navigation_cobol",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !editorHasSelection"
        },
        {
          "command": "cobolplugin.move2anybackwards",
          "group": "navigation_cobol",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !editorHasSelection"
        },
        {
          "submenu": "cobolplugin.aligndataitemsmenu",
          "group": "navigation_cobol"
        },
        {
          "submenu": "cobolplugin.selectionmenu",
          "group": "navigation_cobol"
        },
        {
          "submenu": "cobolplugin.convertmenu",
          "group": "navigation_cobol"
        }
      ],
      "editor/title/context": [
        {
          "command": "workbench.action.closeEditorsToTheLeft",
          "group": "1_close@29"
        }
      ],
      "cobolplugin.selectionmenu": [
        {
          "command": "cobolplugin.extractSelectionToParagraph",
          "group": "cobolplugin",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && editorHasSelection"
        },
        {
          "command": "cobolplugin.extractSelectionToSection",
          "group": "cobolplugin",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && editorHasSelection"
        },
        {
          "command": "cobolplugin.extractSelectionToCopybook",
          "group": "cobolplugin",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && editorHasSelection"
        }
      ],
      "cobolplugin.aligndataitemsmenu": [
        {
          "command": "cobolplugin.alignStorageFirst",
          "group": "aligncobol@1",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && editorHasSelection"
        },
        {
          "command": "cobolplugin.alignStorageLeft",
          "group": "aligncobol@2",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && editorHasSelection"
        },
        {
          "command": "cobolplugin.alignStorageCenter",
          "group": "aligncobol@3",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && editorHasSelection"
        },
        {
          "command": "cobolplugin.alignStorageRight",
          "group": "aligncobol@4",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && editorHasSelection"
        }
      ],
      "cobolplugin.convertmenu": [
        {
          "command": "cobolplugin.selectionToCOBOLHEX",
          "group": "convertcobol@1",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && editorHasSelection"
        },
        {
          "command": "cobolplugin.selectionToHEX",
          "group": "convertcobol@1",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && editorHasSelection"
        },
        {
          "command": "cobolplugin.selectionHEXToASCII",
          "group": "convertcobol@2",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && editorHasSelection"
        },
        {
          "command": "cobolplugin.selectionToCOBOLNXHEX",
          "group": "convertcobol@3",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && editorHasSelection"
        },
        {
          "command": "cobolplugin.selectionToNXHEX",
          "group": "convertcobol@3",
          "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && editorHasSelection"
        }
      ],
      "view/item/context": [
        {
          "command": "cobolplugin.runCommand",
          "when": "view == flat-source-view && viewItem == objects"
        },
        {
          "command": "cobolplugin.runDebugCommand",
          "when": "view == flat-source-view && viewItem == objects"
        }
      ],
      "explorer/context": [
        {
          "command": "cobolplugin.explorerRun",
          "group": "navigation",
          "when": "filesExplorerFocus && resourceExtname == .mfu"
        },
        {
          "command": "cobolplugin.explorerDebug",
          "group": "navigation",
          "when": "filesExplorerFocus && resourceExtname == .int"
        }
      ]
    },
    "submenus": [
      {
        "id": "cobolplugin.aligndataitemsmenu",
        "label": "Align Data Items"
      },
      {
        "id": "cobolplugin.selectionmenu",
        "label": "Extract Selection"
      },
      {
        "id": "cobolplugin.convertmenu",
        "label": "Convert Selection"
      }
    ],
    "keybindings": [
      {
        "key": "ctrl+k ctrl+j",
        "command": "cobolplugin.move2pd",
        "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/"
      },
      {
        "key": "ctrl+alt+p",
        "command": "cobolplugin.move2pd",
        "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/"
      },
      {
        "key": "ctrl+alt+w",
        "command": "cobolplugin.move2ws",
        "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/"
      },
      {
        "key": "ctrl+alt+d",
        "command": "cobolplugin.move2dd",
        "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/"
      },
      {
        "key": "ctrl+alt+.",
        "command": "cobolplugin.move2anyforward",
        "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/"
      },
      {
        "key": "ctrl+alt+,",
        "command": "cobolplugin.move2anybackwards",
        "when": "editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/"
      },
      {
        "key": "tab",
        "command": "cobolplugin.tab",
        "when": "editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "tab",
        "command": "selectNextSuggestion",
        "when": "config.coboleditor.enable_tab_next_or_previous && suggestWidgetVisible && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && suggestWidgetMultipleSuggestions"
      },
      {
        "key": "tab",
        "command": "editor.action.inlineSuggest.commit",
        "when": "config.coboleditor.enable_tab_inline && inlineSuggestionVisible && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !editorTabMovesFocus && !inlineSuggestionHasIndentation"
      },
      {
        "key": "shift+tab",
        "command": "cobolplugin.revtab",
        "when": "editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "shift+tab",
        "command": "selectPrevSuggestion",
        "when": "config.coboleditor.enable_tab_next_or_previous && suggestWidgetVisible && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && suggestWidgetMultipleSuggestions"
      },
      {
        "key": "ctrl+/",
        "command": "cobolplugin.commentline",
        "when": "config.coboleditor.comment_line && editorTextFocus && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !editorReadonly"
      },
      {
        "key": "alt+shift+a",
        "command": "cobolplugin.change_lang_to_acu",
        "when": "editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "alt+shift+c",
        "command": "cobolplugin.change_lang_to_cobol",
        "when": "editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "alt+right",
        "command": "cobolplugin.padTo72",
        "when": "editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+alt+a",
        "command": "cobolplugin.indentToCursor",
        "when": "editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+l",
        "command": "cobolplugin.leftAdjustLine",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+alt+l",
        "command": "cobolplugin.leftAdjustLine",
        "when": "editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "alt+a",
        "command": "editor.action.selectAll",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+a",
        "command": "cursorLineStart",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+b",
        "command": "cursorLeft",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+c",
        "command": "editor.action.clipboardPasteAction",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+d",
        "command": "deleteRight",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+e",
        "command": "cursorLineEnd",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+f",
        "command": "cursorRight",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+h",
        "command": "deleteLeft",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+j",
        "command": "editor.action.insertLineAfter",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+k",
        "command": "deleteAllRight",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+m",
        "command": "editor.action.insertLineBefore",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+t",
        "command": "cobolplugin.transposeSelection",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "ctrl+z",
        "command": "scrollLineUp",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      },
      {
        "key": "alt+z",
        "command": "scrollLineDown",
        "when": "config.coboleditor.xedit_keymap && editorLangId =~ /^COBOL$|^BITLANG-COBOL$|^ACUCOBOL$|^COBOLIT$/ && !inSnippetMode"
      }
    ],
    "snippets": [
      {
        "language": "COBOL",
        "path": "./snippets/cobol.json"
      },
      {
        "language": "markdown",
        "path": "./snippets/markdown.json"
      },
      {
        "language": "COBOL",
        "path": "./snippets/cobol-compound.json"
      },
      {
        "language": "ACUCOBOL",
        "path": "./snippets/acucobol.json"
      },
      {
        "language": "BITLANG-COBOL",
        "path": "./snippets/cobol.json"
      },
      {
        "language": "COBOLIT",
        "path": "./snippets/cobolit.json"
      },
      {
        "language": "dir",
        "path": "./snippets/dir.json"
      },
      {
        "language": "JCL",
        "path": "./snippets/jcl.json"
      },
      {
        "language": "jcl",
        "path": "./snippets/jcl.json"
      }
    ],
    "problemPatterns": [
      {
        "name": "mfcobol-msbuild",
        "regexp": "^\\s*(.*)\\((\\d+),(\\d+)\\):\\s+(error|warning)\\s+(.*)\\s+\\[.*$",
        "file": 1,
        "line": 2,
        "column": 3,
        "severity": 4,
        "message": 5
      },
      {
        "name": "mfcobol-errformat2-netx-sx",
        "regexp": "^\\*+\\s+(COBCH\\d+)([USEWI])\\s+([^:]+):\\s+(.*)\\((\\d+),(\\d+).*\\).*$",
        "code": 1,
        "severity": 2,
        "message": 3,
        "file": 4,
        "line": 5,
        "column": 6
      },
      {
        "name": "mfcobol-errformat2-copybook-netx-sx",
        "regexp": "^\\*+\\s+(COBCH\\d+)([USEWI])\\s+([^:]+):[^,]+,(.*)\\((\\d+),(\\d+).*\\).*$",
        "code": 1,
        "severity": 2,
        "message": 3,
        "file": 4,
        "line": 5,
        "column": 6
      },
      {
        "name": "mfcobol-errformat3-netx-sx",
        "regexp": "^(.*)\\((\\d+),(\\d+)\\)\\s+:\\s+(unrecoverable|severe|error|warning|information)\\s+(\\d+)\\s+:\\s+(.*)$",
        "file": 1,
        "line": 2,
        "column": 3,
        "severity": 4,
        "code": 5,
        "message": 6
      },
      {
        "name": "mfcobol-errformat2",
        "regexp": "^\\*+\\s+(COB[A-Z][A-Z]\\d+)([USEWI])\\s+(.*)\\s+(.*)\\((\\d+),(\\d+),.*\\)$",
        "code": 1,
        "severity": 2,
        "message": 3,
        "file": 4,
        "line": 5,
        "column": 6
      },
      {
        "name": "mfcobol-errformat2-copybook",
        "regexp": "^\\*+\\s+(COB[A-Z][A-Z]\\d+)([USEWI])\\s+([^:]+)[^,]+,(\\S.*)\\((\\d+),(\\d+),.*\\).*$",
        "code": 1,
        "severity": 2,
        "message": 3,
        "file": 4,
        "line": 5,
        "column": 6
      },
      {
        "name": "mfcobol-errformat2-basefn",
        "regexp": "^\\*+\\s+(COB[A-Z][A-Z]\\d+)([a-zA-Z])\\s+([^:]+):\\s+[\\.\\/].*[\\/](\\S*)\\((\\d+)(\\d+)[,].*\\).*$",
        "code": 1,
        "severity": 2,
        "message": 3,
        "file": 4,
        "line": 5,
        "column": 6
      },
      {
        "name": "mfcobol-errformat3-absolute",
        "regexp": "(.*)\\((\\d+),(\\d+)\\).*(unrecoverable|severe|error|warning|information)\\s+(COB[A-Z][A-Z]\\d+)\\s+:\\s+(.*)$",
        "file": 1,
        "line": 2,
        "column": 3,
        "severity": 4,
        "code": 5,
        "message": 6
      },
      {
        "name": "mfcobol-errformat3",
        "regexp": "(.*)\\((\\d+),(\\d+)\\).*(unrecoverable|severe|error|warning|information)\\s+(COB[A-Z][A-Z]\\d+)\\s+:\\s+(.*).*$",
        "file": 1,
        "line": 2,
        "column": 3,
        "severity": 4,
        "code": 5,
        "message": 6
      },
      {
        "name": "mfcobol-errformat3-info",
        "regexp": "(.*)\\((\\d+),(\\d+)\\).*(information)\\s+(COB[A-Z][A-Z]\\d+)\\s+:\\s+(.*).*$",
        "file": 1,
        "line": 2,
        "column": 3,
        "code": 5,
        "message": 6
      },
      {
        "name": "mfcobol-errformat3-basefn",
        "regexp": "\\.\\..*[/\\x5c](.*)\\((\\d+),(\\d+)\\).*(unrecoverable|severe|error|warning|information)\\s+(COB[A-Z][A-Z]\\d+)\\s+:\\s+(.*).*$",
        "file": 1,
        "line": 2,
        "column": 3,
        "severity": 4,
        "code": 5,
        "message": 6
      },
      {
        "name": "mfcobol-errformat3-info-basefn",
        "regexp": "\\.\\..*[/\\x5c](.*)\\((\\d+),(\\d+)\\).*(information)\\s+(COB[A-Z][A-Z]\\d+)\\s+:\\s+(.*).*$",
        "file": 1,
        "line": 2,
        "column": 3,
        "code": 4,
        "message": 6
      },
      {
        "name": "cobolit-cobc",
        "regexp": "^(.*):(\\d+): ([eE]rror|[wW]arning):\\s+(.*)$",
        "file": 1,
        "line": 2,
        "severity": 3,
        "message": 4
      },
      {
        "name": "cobolit-note-cobc",
        "regexp": "^(.*):(\\d+): ([nN]ote:|[wW]arning: ->)\\s+(.*)$",
        "file": 1,
        "line": 2,
        "message": 4
      },
      {
        "name": "acucobol-ccbl",
        "regexp": "^(.*),\\sline\\s(\\d+):\\s(.*)$",
        "file": 1,
        "location": 2,
        "message": 3,
        "loop": true
      },
      {
        "name": "acucobol-warning-ccbl",
        "regexp": "^(.*),\\sline\\s(\\d+):\\s([Ww]arning):\\s(.*)$",
        "file": 1,
        "location": 2,
        "severity": 3,
        "message": 4,
        "loop": true
      },
      {
        "name": "procobol-preprocessor",
        "patterns": [
          {
            "regexp": "^Error at line (\\d+), column (\\d+) in file (.*)$",
            "line": 1,
            "column": 2,
            "file": 3
          },
          {
            "regexp": "^(.*)$"
          },
          {
            "regexp": "^(.*)$"
          },
          {
            "regexp": "^(\\s+\\d+\\s+)?([^:]*):\\s+(.*)$",
            "message": 3,
            "code": 2
          }
        ]
      }
    ],
    "problemMatchers": [
      {
        "name": "mfcobol-msbuild",
        "owner": "cobol",
        "fileLocation": "autoDetect",
        "pattern": "$mfcobol-msbuild",
        "source": "MSBuild"
      },
      {
        "name": "mfcobol-errformat3-absolute",
        "owner": "cobol",
        "fileLocation": "absolute",
        "pattern": "$mfcobol-errformat3-absolute",
        "source": "VC"
      },
      {
        "name": "mfcobol-errformat3",
        "owner": "cobol",
        "fileLocation": "autoDetect",
        "pattern": "$mfcobol-errformat3",
        "source": "VC"
      },
      {
        "name": "mfcobol-errformat3-info",
        "owner": "cobol",
        "fileLocation": "autoDetect",
        "pattern": "$mfcobol-errformat3-info",
        "severity": "info",
        "source": "VC"
      },
      {
        "name": "mfcobol-errformat3-basefn",
        "owner": "cobol",
        "fileLocation": [
          "autoDetect",
          "${workspaceFolder}"
        ],
        "pattern": "$mfcobol-errformat3-basefn",
        "source": "VC"
      },
      {
        "name": "mfcobol-errformat3-info-basefn",
        "owner": "cobol",
        "fileLocation": [
          "autoDetect",
          "${workspaceFolder}"
        ],
        "severity": "info",
        "pattern": "$mfcobol-errformat3-info-basefn",
        "source": "VC"
      },
      {
        "name": "mfcobol-errformat2-netx-sx",
        "owner": "cobol",
        "fileLocation": "autoDetect",
        "pattern": "$mfcobol-errformat2-netx-sx",
        "source": "NETX/SX"
      },
      {
        "name": "mfcobol-errformat2-copybook-netx-sx",
        "owner": "cobol",
        "fileLocation": "autoDetect",
        "pattern": "$mfcobol-errformat2-copybook-netx-sx",
        "source": "NETX/SX"
      },
      {
        "name": "mfcobol-errformat3-netx-sx",
        "owner": "cobol",
        "fileLocation": "autoDetect",
        "pattern": "$mfcobol-errformat3-netx-sx",
        "source": "NETX/SX"
      },
      {
        "name": "mfcobol-errformat2-copybook",
        "owner": "cobol",
        "fileLocation": "autoDetect",
        "pattern": "$mfcobol-errformat2-copybook",
        "source": "VC"
      },
      {
        "name": "mfcobol-errformat2",
        "owner": "cobol",
        "fileLocation": "autoDetect",
        "pattern": "$mfcobol-errformat2",
        "source": "VC"
      },
      {
        "name": "mfcobol-errformat2-basefn",
        "owner": "cobol",
        "fileLocation": [
          "autoDetect",
          "${workspaceFolder}"
        ],
        "pattern": "$mfcobol-errformat2-basefn",
        "source": "VC"
      },
      {
        "name": "cobolit-cobc",
        "owner": "cobol",
        "fileLocation": "autoDetect",
        "pattern": "$cobolit-cobc",
        "source": "COBOL-IT"
      },
      {
        "name": "cobolit-note-cobc",
        "owner": "cobol",
        "fileLocation": "autoDetect",
        "pattern": "$cobolit-note-cobc",
        "severity": "info",
        "source": "COBOL-IT"
      },
      {
        "name": "acucobol-ccbl",
        "owner": "cobol",
        "fileLocation": "autoDetect",
        "pattern": "$acucobol-ccbl",
        "source": "ACUCOBOL-GT"
      },
      {
        "name": "acucobol-warning-ccbl",
        "owner": "cobol",
        "fileLocation": "autoDetect",
        "pattern": "$acucobol-warning-ccbl",
        "source": "ACUCOBOL-GT"
      },
      {
        "name": "procobol-preprocessor",
        "fileLocation": "autoDetect",
        "pattern": "$procobol-preprocessor",
        "source": "Pro*COBOL",
        "owner": "cobol",
        "severity": "error"
      }
    ],
    "taskDefinitions": [
      {
        "type": "COBOLBuildScript",
        "properties": {
          "arguments": {
            "type": "string"
          }
        }
      }
    ]
  },
  "scripts": {
    "vscode:prepublish": "npm run compile && webpack --mode production",
    "webpack": "npm run compile && webpack --mode development",
    "package-web": "webpack --mode production --devtool hidden-source-map",
    "watch-web": "webpack --watch --mode development",
    "just-compile": "tsc -b",
    "compile": "tsc -b",
    "compile-web": "webpack",
    "test-compile": "tsc -p ./",
    "watch": "tsc -b -w",
    "lint": "eslint src --ext ts",
    "pretest": "npm run compile && npm run lint",
    "test": "node ./out/test/runTest.js",
    "find-deadcode": "./node_modules/.bin/ts-prune | grep -v \"used in module\"",
    "open-in-browser": "vscode-test-web -version=stable --browserType=chromium --platformDevelopmentPath=. ."
  },
  "devDependencies": {
    "@types/glob": "^8.1.0",
    "@types/glob-to-regexp": "^0.4.1",
    "@types/mocha": "^10.0.1",
    "@types/node": "^18.15.3",
    "@types/vscode": "^1.76.0",
    "@types/webpack-env": "^1.18.0",
    "@typescript-eslint/eslint-plugin": "^5.56.0",
    "@typescript-eslint/parser": "^5.56.0",
    "@vscode/test-electron": "^2.3.0",
    "@vscode/test-web": "^0.0.35",
    "ansi-regex": ">=6.0.1",
    "assert": "^2.0.0",
    "depcheck": "^1.4.3",
    "eslint": "^8.36.0",
    "glob": "^8.1.0",
    "glob-to-regexp": "^0.4.1",
    "merge": "2.1.1",
    "mocha": "^10.2.0",
    "nth-check": ">=2.1.1",
    "process": "^0.11.10",
    "ts-loader": "^9.4.2",
    "typescript": "^5.0.2",
    "vsce": "^2.14.0",
    "webpack": "^5.76.2",
    "webpack-cli": "^5.0.1"
  },
  "dependencies": {
    "ansi-regex": ">=6.0.1",
    "buffer": "^6.0.3",
    "crypto-browserify": "^3.12.0",
    "glob-to-regexp": "^0.4.1",
    "memfs": "^3.4.13",
    "n-readlines": "^1.0.1",
    "os-browserify": "^0.3.0",
    "path-browserify": "^1.0.1",
    "performance-now": "2.1.0",
    "promisify-child-process": "^4.1.1",
    "properties-reader": "^2.2.0",
    "stream-browserify": "^3.0.0",
    "trie-search": "^1.3.6",
    "ts-prune": "^0.10.3",
    "url": "^0.11.0"
  },
  "extensionDependencies": []
}


*)
