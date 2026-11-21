# 15 · Publicar nas lojas (Google Play, App Store e itch.io)

> ⏱️ leitura ~1h; publicar de verdade leva dias (revisões e testes das lojas)
> 🎯 Saber o caminho completo da build ao jogo na loja — mesmo que você só publique depois da pós
> ⚠️ **Regras, preços e requisitos das lojas mudam com frequência.** Este guia dá o mapa; confira sempre as
> páginas oficiais (Play Console Help e App Store Connect Help) antes de cada etapa.

## Comece pelo mais fácil: itch.io

Antes das lojas, publique no **[itch.io](https://itch.io)** (grátis, sem revisão, em minutos):
- Envie o **APK** para quem tem Android baixar.
- Ou exporte para **Web** (*Project → Export → Web*) e o jogo roda no navegador do celular. O renderer
  *Compatibility* é o que funciona na Web.
- Ótimo para mostrar no portfólio, em game jams e para o professor/colegas da pós.

## Antes de qualquer loja: checklist do jogo

- [ ] nome, ícone (1024×1024 sem transparência para iOS) e splash próprios
- [ ] **versão**: Android → `version/code` (número inteiro que **sempre aumenta** a cada envio) e `version/name` ("1.0.0");
      iOS → *Short Version* e *Version*
- [ ] export em modo **release** (desmarque *Export With Debug*)
- [ ] testado em aparelhos reais com telas diferentes
- [ ] **política de privacidade** (uma página web simples). As duas lojas exigem — mesmo que o jogo não colete nada,
      diga isso nela
- [ ] se usa anúncios, compras, analytics ou login: saiba exatamente quais dados cada SDK coleta (formulários das lojas)

## Google Play

### 1. Conta
- **Google Play Console**: taxa única de inscrição (historicamente US$ 25) + verificação de identidade.
- Contas **pessoais novas** precisam fazer um **teste fechado** com um número mínimo de testadores durante um período
  (a regra recente: 12 testadores por 14 dias) antes de liberar a produção. Combine com colegas da pós!

### 2. Chave de upload (keystore de release)

```bash
keytool -v -genkey -keystore minha-release.keystore -alias meujogo \
  -keyalg RSA -validity 10000
```

- **Guarde a keystore e a senha FORA do repositório** (o hook de pré-commit bloqueia `*.keystore` por isso)
  — num gerenciador de senhas + backup. Perder = dor de cabeça para atualizar o app.
- Com o **Play App Signing** (padrão), o Google guarda a chave final; a sua vira "chave de upload" (recuperável).
- No Godot: preset Android → *Keystore → Release*, *Release User*, *Release Password*. O Godot guarda as senhas em
  `.godot/export_credentials.cfg` (fora do git) e não no `export_presets.cfg`.

### 3. Gerar o AAB
- A Play Store exige **Android App Bundle (.aab)**, não APK.
- No Godot isso requer o **build com Gradle**: *Project → Install Android Build Template*, e no preset:
  *Gradle Build → Use Gradle Build* ✅ e *Export Format = AAB*.
- Isso também é necessário para **plugins Android** (anúncios, compras, serviços do Google).

### 4. Play Console
1. Criar app → preencher **ficha da loja**: descrição curta e longa, ícone 512×512, *feature graphic* 1024×500,
   capturas de tela do celular (mínimo 2).
2. **Classificação etária** (questionário IARC), **segurança dos dados** (*Data safety*), público-alvo, anúncios sim/não.
3. **Testes**: envie o AAB para *Teste interno* (até 100 testadores, quase instantâneo) → *Teste fechado* → *Produção*.
4. Revisão do Google: de horas a dias.

## App Store (iPhone/iPad)

### 1. Conta
- **Apple Developer Program**: anuidade (historicamente US$ 99/ano). Sem ela dá para testar no seu aparelho
  (lição 11), mas não publicar nem usar TestFlight.

### 2. Configuração
1. Em developer.apple.com: o **Bundle ID** do app (ex: `com.seunome.chuvadeestrelas`) — o Xcode pode criar sozinho
   com *Automatically manage signing*.
2. Em **App Store Connect**: *Meus Apps → +* → novo app com esse Bundle ID.
3. No Godot (preset iOS): *Team ID*, *Bundle Identifier*, versão, ícones, *Export Method Release = App Store*.

### 3. Enviar
1. Exporte o projeto Xcode pelo Godot e abra no Xcode.
2. Selecione *Any iOS Device (arm64)* → **Product → Archive**.
3. No **Organizer**: *Distribute App → App Store Connect → Upload*.
4. A build aparece no App Store Connect em alguns minutos → **TestFlight** para testar com até milhares de pessoas
   (testadores externos passam por uma revisão rápida).
5. Preencha a página: descrição, palavras-chave, **capturas de tela** nos tamanhos pedidos (a Apple pede ao menos o
   tamanho de iPhone maior; confira a lista atual), **privacidade do app** (*App Privacy*), classificação etária.
6. *Enviar para revisão*. Rejeições comuns: app com pouca funcionalidade, links quebrados, falta de política de
   privacidade, crash na revisão. Leia as *App Review Guidelines* antes.

## Monetização (visão geral)

| Modelo | Como no Godot |
|---|---|
| Pago | só configurar o preço na loja |
| Compras no app (IAP) | plugins: oficial do Google Play Billing (Android) e plugin de StoreKit (iOS) |
| Anúncios | plugins da comunidade para AdMob e outros (pesquise os mais mantidos para a sua versão) |

Plugins exigem Gradle build (Android) e configuração no Xcode (iOS), e mudam com frequência — verifique se o plugin
suporta a **sua** versão do Godot antes de começar. Para a pós e o portfólio, um jogo **gratuito e sem anúncios** é o
caminho mais simples.

## 🏋️ Exercícios

1. Publique o seu Chuva de Estrelas (ou o projeto final) no **itch.io** como página privada/rascunho, com versão Web e APK.
2. Gere uma keystore de release, configure no preset e exporte um AAB (não precisa enviar).
3. Escreva a descrição curta (80 caracteres) e longa da loja para o seu projeto final e tire 4 capturas de tela boas.

## ✅ Eu sei...

- [ ] publicar no itch.io (Web e APK)
- [ ] gerar e guardar com segurança uma keystore de release
- [ ] por que a Play Store exige AAB e como gerar no Godot
- [ ] o caminho Archive → TestFlight → revisão na Apple
- [ ] o que as lojas pedem além do jogo (privacidade, classificação, screenshots)

🎓 Fim da trilha Godot!
