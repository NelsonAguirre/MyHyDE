local prompts = {
  -- Explain = "Please explain how the following code works.", -- Prompt to explain code
  -- Review = "Please review the following code and provide suggestions for improvement.", -- Prompt to review code
  -- Tests = "Please explain how the selected code works, then generate unit tests for it.", -- Prompt to generate unit tests
  -- Refactor = "Please refactor the following code to improve its clarity and readability.", -- Prompt to refactor code
  -- FixCode = "Please fix the following code to make it work as intended.", -- Prompt to fix code
  -- FixError = "Please explain the error in the following text and provide a solution.", -- Prompt to fix errors
  -- BetterNamings = "Please provide better names for the following variables and functions.", -- Prompt to suggest better names
  -- Documentation = "Please provide documentation for the following code.", -- Prompt to generate documentation
  -- JsDocs = "Please provide JsDocs for the following code.", -- Prompt to generate JsDocs
  -- DocumentationForGithub = "Please provide documentation for the following code ready for GitHub using markdown.", -- Prompt to generate GitHub documentation
  -- CreateAPost = "Please provide documentation for the following code to post it in social media, like Linkedin, it has be deep, well explained and easy to understand. Also do it in a fun and engaging way.", -- Prompt to create a social media post
  -- SwaggerApiDocs = "Please provide documentation for the following API using Swagger.", -- Prompt to generate Swagger API docs
  -- SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.", -- Prompt to generate Swagger JsDocs
  -- Summarize = "Please summarize the following text.", -- Prompt to summarize text
  -- Spelling = "Please correct any grammar and spelling errors in the following text.", -- Prompt to correct spelling and grammar
  -- Wording = "Please improve the grammar and wording of the following text.", -- Prompt to improve wording
  -- Concise = "Please rewrite the following text to make it more concise.", -- Prompt to make text concise
}

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    enabled= true,
    opts = {
      prompts = prompts,
      system_prompt = "Este GPT es un clon del usuario, un arquitecto líder frontend especializado en Angular y React, con experiencia en arquitectura limpia, arquitectura hexagonal y separación de lógica en aplicaciones escalables. Tiene un enfoque técnico pero práctico, con explicaciones claras y aplicables, siempre con ejemplos útiles para desarrolladores con conocimientos intermedios y avanzados.\n\nHabla con un tono profesional pero cercano, relajado y con un toque de humor inteligente. Evita formalidades excesivas y usa un lenguaje directo, técnico cuando es necesario, pero accesible. Sin caer en clichés .\n\nSus principales áreas de conocimiento incluyen:\n- Desarrollo frontend con Angular, React y gestión de estado avanzada (Redux, Signals).\n- Arquitectura de software con enfoque en Clean Architecture, Hexagonal Architecure y Scream Architecture.\n- Implementación de buenas prácticas en TypeScript, testing unitario y end-to-end.\n- Loco por la modularización, atomic design y el patrón contenedor presentacional \n- Herramientas de productividad como LazyVim, Tmux, Zellij, OBS y Stream Deck.\n- Mentoría y enseñanza de conceptos avanzados de forma clara y efectiva.\n\nA la hora de explicar un concepto técnico:\n1. Explica el problema que el usuario enfrenta.\n2. Propone una solución clara y directa, con ejemplos si aplica.\n3. Menciona herramientas o recursos que pueden ayudar.\n\nSi el tema es complejo, usa analogías prácticas, especialmente relacionadas con construcción y arquitectura. Si menciona una herramienta o concepto, explica su utilidad y cómo aplicarlo sin redundancias.\n\nAdemás, tiene experiencia en charlas técnicas y generación de contenido. Puede hablar sobre la importancia de la introspección, cómo balancear liderazgo y comunidad, y cómo mantenerse actualizado en tecnología mientras se experimenta con nuevas herramientas. Su estilo de comunicación es directo, pragmático y sin rodeos, pero siempre accesible y ameno.\n\nEsta es una transcripción de uno de sus vídeos para que veas como habla:\n\nLe estaba contando la otra vez que tenía una condición Que es de adulto altamente calificado no sé si lo conocen pero no es bueno el oto lo está hablando con mi mujer y y a mí cuando yo era chico mi mamá me lo dijo en su momento que a mí me habían encontrado una condición Que ti un iq muy elevado cuando era muy chico eh pero muy elevado a nivel de que estaba 5 años o 6 años por delante de un niño", 
      model = 'gpt-4.1',           -- AI model to use
      temperature = 0.1,           -- Lower = focused, higher = creative
      window = {
        title = '🤖 AI Assistant',
        layout = 'vertical',       -- 'vertical', 'horizontal', 'float'
        width = 0.5,              -- 50% of screen width
      },
      auto_insert_mode = false,     -- Enter insert mode when opening
      answer_header = " ",
      headers = {
        user = ' Gentleman',
        assistant = '󱗞  The Gentleman 󱗞',
        tool = '🔧 Tool',
      },
      separator= '',

    mappings = {
        complete = {
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-r>",
          insert = "<C-r>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        toggle_sticky = {
          normal = "grr",
        },
        clear_stickies = {
          normal = "grx",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        jump_to_diff = {
          normal = "gj",
        },
        quickfix_answers = {
          normal = "gqa",
        },
        quickfix_diffs = {
          normal = "gqd",
        },
        yank_diff = {
          normal = "gy",
          register = '"', -- Default register to use for yanking
        },
        show_diff = {
          normal = "gd",
          full_diff = false, -- Show full diff instead of unified diff when showing diff window
        },
        show_info = {
          normal = "gi",
        },
        show_context = {
          normal = "gc",
        },
        show_help = {
          normal = "gh",
        },
      },
    },
  },
}
