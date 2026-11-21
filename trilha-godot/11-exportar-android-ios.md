# 11 · Exportar para Android e iPhone

> ⏱️ ~3h (a primeira vez sempre dá algum trabalho!) · 🎯 Seu jogo rodando no seu celular
> ⚠️ Os nomes exatos dos campos mudam um pouco entre versões. Se algo não bater, a
> [documentação oficial de exportação](https://docs.godotengine.org/en/stable/tutorials/export/index.html)
> da **sua** versão é a fonte da verdade — e o painel de export mostra em vermelho o que falta.

## Passo 0 — Export Templates

*Editor → Manage Export Templates → Download and Install*. São os "motores" pré-compilados para cada plataforma
(~1 GB). Uma vez por versão do Godot.

## Android (a partir do Mac)

### Instalações (uma vez)

1. **JDK 17** (OpenJDK). Com Homebrew: `brew install --cask temurin@17`
   (confira na documentação da sua versão do Godot se ela pede outra versão).
2. **Android SDK** — o jeito mais simples é instalar o **Android Studio** e, no *SDK Manager*, instalar:
   - Android SDK Platform-Tools
   - Android SDK Build-Tools (a versão recomendada na doc)
   - Android SDK Platform (a API alvo da doc)
   - Android SDK Command-line Tools
   - (NDK e CMake **não** são necessários para exportar)
3. No Godot: *Editor → Editor Settings → Export → Android*:
   - **Java SDK Path**: geralmente `/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home`
   - **Android SDK Path**: geralmente `~/Library/Android/sdk` (caminho completo, ex: `/Users/SEU_USUARIO/Library/Android/sdk`)
4. Uma *debug keystore* é necessária para assinar o APK de teste — versões recentes do Godot geram sozinhas.
   Se o painel reclamar, crie:
   ```bash
   keytool -keyalg RSA -genkeypair -alias androiddebugkey -keypass android \
     -keystore debug.keystore -storepass android -dname "CN=Android Debug,O=Android,C=US" -validity 9999
   ```
   e aponte para ela em *Editor Settings → Export → Android → Debug Keystore*.

### No celular

1. *Configurações → Sobre o telefone* → toque 7× em **Número da versão** → modo desenvolvedor ativado.
2. *Opções do desenvolvedor* → **Depuração USB** ✅.
3. Conecte no Mac por cabo e aceite o pedido de confiança no celular.
4. Teste no terminal: `~/Library/Android/sdk/platform-tools/adb devices` deve listar o aparelho.

### Exportando

1. *Project → Export → Add... → Android*.
2. Preencha: **Package → Unique Name** (ex: `com.seunome.chuvadeestrelas`), nome, ícone.
3. *Permissions*: marque **Vibrate** se usar `vibrate_handheld`.
4. **One-click deploy**: com o celular conectado e o preset marcado como *Runnable*, aparece um ícone do Android
   no canto superior direito do editor. Clique → instala e abre no celular. 🎉
5. Ou **Export Project** → gera um `.apk` que você pode mandar para amigos (precisam permitir "fontes desconhecidas").

> Play Store exige **AAB** (Android App Bundle) assinado com sua keystore de *release* — guarde-a com muito cuidado.
> Isso só importa quando for publicar.

### Remote Debug

Com *Debug → Deploy with Remote Debug* ligado, o one-click deploy conecta o celular ao editor:
`print()`, erros, breakpoints e o Profiler funcionam **com o jogo rodando no aparelho**.

## iPhone / iPad

Precisa de Mac (✅ você tem) e **Xcode** (App Store, grátis, grande).

1. Abra o Xcode uma vez, aceite a licença, e em *Xcode → Settings → Accounts* adicione seu **Apple ID**.
   Uma conta gratuita já permite instalar no **seu próprio** aparelho (o app expira em 7 dias; reinstale).
   Publicar na App Store exige o Apple Developer Program (pago, anual).
2. No iPhone: *Ajustes → Privacidade e Segurança → Modo de Desenvolvedor* (aparece depois de conectar ao Xcode).
3. No Godot: *Project → Export → Add... → iOS*.
   - **App Store Team ID**: veja no Xcode (Settings → Accounts → seu time) ou em developer.apple.com.
   - **Bundle Identifier**: ex `com.seunome.chuvadeestrelas` (único).
   - Ícones: o Godot pede alguns tamanhos — use um PNG 1024×1024 como base.
4. **Export Project** → gera um **projeto Xcode**. Abra o `.xcodeproj`, escolha seu iPhone no topo e clique ▶︎.
5. No primeiro run, o iPhone pode pedir para confiar no desenvolvedor:
   *Ajustes → Geral → VPN e Gerenciamento de Dispositivos*.

## Renderer e compatibilidade

| Renderer | Android | iOS | Quando |
|---|---|---|---|
| Compatibility | OpenGL ES 3.0 — quase todo aparelho | sim | 2D, aparelhos antigos, jogos simples |
| Mobile | Vulkan | Metal | 3D com mais recursos, aparelhos razoavelmente recentes |

Você pode definir um renderer diferente para mobile em *Project Settings → Rendering → Renderer → Rendering Method.mobile*.

## Ícone e splash

- *Project Settings → Application → Config → Icon* (base) e os campos de ícone de cada preset de export
  (Android tem ícone adaptativo: *foreground* + *background*).
- *Application → Boot Splash*: imagem e cor de fundo da tela de carregamento.

## Checklist de problemas comuns

| Sintoma | Causa provável |
|---|---|
| Botão de one-click deploy não aparece | preset não marcado como *Runnable*, ou `adb devices` não vê o celular |
| "Invalid package name" | use só letras minúsculas, números, `_` e pontos: `com.nome.jogo` |
| Tela preta no Android antigo | renderer Mobile em aparelho sem Vulkan → use Compatibility |
| Jogo deitado | *Handheld → Orientation* errada |
| Pixel art borrada no celular | filtro de textura não está em Nearest |
| Xcode: "Signing requires a development team" | selecione seu time em *Signing & Capabilities* do target |

## 🏋️ Exercícios

1. Rode o **Chuva de Estrelas (gabarito)** no seu celular via one-click deploy.
2. Rode o **seu** jogo. Jogue de verdade por 5 minutos e anote 3 coisas que "no Mac pareciam ok".
3. Use o Remote Debug e veja o FPS no Monitor enquanto joga.
4. Mande o APK (ou TestFlight, se tiver conta paga) para alguém e observe a pessoa jogar **sem explicar nada**.

## ✅ Eu sei...

- [ ] instalar templates e configurar SDKs
- [ ] fazer one-click deploy no Android
- [ ] exportar o projeto Xcode e rodar no iPhone
- [ ] usar Remote Debug com o aparelho
- [ ] diferença entre APK de debug e AAB de release

➡️ Próxima: [12 · Introdução ao 3D](12-introducao-3d.md)
