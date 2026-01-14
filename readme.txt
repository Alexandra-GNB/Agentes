#antes de ejecutar, ve a VS Code y desarga la extensión:  GitHub Copilot Chat (v0.36.0) o superior. 
Si usas Claude u otra IA desde la web (claude.ai) en lugar de VS Code, no puedes usar estos agentes directamente ya que son específicos de la arquitectura de VS Code Copilot. Sin embargo, puedes lograr un flujo similar copiando el contenido de cada agente (las instrucciones dentro de los archivos .agent.md) y usándolas como prompts de sistema personalizados en tus conversaciones con Claude. Por ejemplo, iniciarías una conversación diciéndole a Claude "actúa como un agente de planificación siguiendo estas reglas..." y pegarías las instrucciones del agente Plan.

# Analizar código existente
@refine Analiza el archivo api-client.ts y sugiere mejoras

# Implementar basado en análisis
@adapt Implementa las recomendaciones de Refine: separar auth, requests y caching

# Planificar y luego implementar
@plan Quiero refactorizar el módulo de usuarios

# Luego: handoff a Adapt para ejecutar
