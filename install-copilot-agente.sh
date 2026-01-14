#!/bin/bash

# Script de instalación y configuración de Agentes personalizados para GitHub Copilot
# Asegúrate de tener instalada la extensión GitHub Copilot Chat (mínimo v0.36.0)

echo "🤖 Instalando agentes personalizados para GitHub Copilot..."

# Detectar sistema operativo y definir ruta de extensiones
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows
    EXTENSIONS_DIR="$USERPROFILE/.vscode/extensions/github.copilot-chat-*/assets/agents"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    EXTENSIONS_DIR="$HOME/.vscode/extensions/github.copilot-chat-*/assets/agents"
else
    # Linux
    EXTENSIONS_DIR="$HOME/.vscode/extensions/github.copilot-chat-*/assets/agents"
fi

# Expandir el wildcard para obtener la ruta exacta
AGENTS_PATH=$(echo $EXTENSIONS_DIR)

if [ ! -d "$AGENTS_PATH" ]; then
    echo "❌ Error: No se encontró la carpeta de agentes de GitHub Copilot"
    echo "   Asegúrate de tener instalada la extensión GitHub Copilot Chat v0.36.0+"
    echo "   Instálala desde: https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat"
    exit 1
fi

echo "📂 Carpeta de agentes encontrada: $AGENTS_PATH"

# Crear archivos de agentes
echo "📝 Creando agente Plan..."
cat > "$AGENTS_PATH/plan.agent.md" << 'EOF'
---
name: Plan
description: Investiga y elabora planes de múltiples pasos
argument-hint: Describe el objetivo o problema a investigar
tools: ['search', 'runSubagent', 'usages', 'problems', 'changes']
handoffs:
  - label: Iniciar Implementación
    agent: agent
    prompt: Inicia la implementación
  - label: Analizar Técnicamente
    agent: refine
    prompt: Analiza técnicamente este plan antes de implementar
---
Eres un AGENTE DE PLANIFICACIÓN. Tu única responsabilidad es crear planes claros y accionables, NUNCA implementar.

# [Contenido completo del agente aquí - truncado por brevedad]
EOF

echo "📝 Creando agente Refine..."
cat > "$AGENTS_PATH/refine.agent.md" << 'EOF'
---
name: Refine
description: Analiza y refina scripts con criterio técnico avanzado
argument-hint: Describe el script o problema técnico a refinar
tools: ['search', 'usages', 'problems', 'runSubagent']
handoffs:
  - label: Implementar Refinamiento
    agent: adapt
    prompt: Implementa las mejoras técnicas propuestas
---
Eres un AGENTE DE REFINAMIENTO TÉCNICO especializado en análisis profundo de código.

# [Contenido completo del agente aquí - truncado por brevedad]
EOF

echo "📝 Creando agente Adapt..."
cat > "$AGENTS_PATH/adapt.agent.md" << 'EOF'
---
name: Adapt
description: Implementa adaptaciones y mejoras técnicas en scripts
argument-hint: Describe las adaptaciones o mejoras a implementar
tools: ['search', 'usages', 'problems', 'runSubagent']
handoffs:
  - label: Analizar Primero
    agent: refine
    prompt: Analiza técnicamente antes de implementar
---
Eres un AGENTE DE IMPLEMENTACIÓN ADAPTATIVA especializado en ejecutar cambios técnicos.

# [Contenido completo del agente aquí - truncado por brevedad]
EOF

echo ""
echo "✅ Agentes instalados correctamente en: $AGENTS_PATH"
echo ""
echo "🚀 Cómo usar los agentes en VS Code:"
echo "   1. Abre el chat de GitHub Copilot (Ctrl+Shift+I o Cmd+Shift+I)"
echo "   2. Menciona un agente con @ seguido del nombre:"
echo "      - @plan [tu objetivo] → Crea un plan estructurado"
echo "      - @refine [archivo o código] → Analiza y sugiere mejoras"
echo "      - @adapt [cambios a implementar] → Ejecuta mejoras técnicas"
echo ""
echo "📖 Ejemplo de uso:"
echo "   @plan Necesito refactorizar el módulo de autenticación"
echo "   @refine Analiza src/auth/login.ts para optimización"
echo "   @adapt Implementa las mejoras sugeridas por Refine"
echo ""
echo "⚠️  Nota: Necesitas una suscripción activa de GitHub Copilot para usar estos agentes"