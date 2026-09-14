````markdown
# NeuroSketch

Aplicação desenvolvida em **Flutter**, uma ferramenta de apoio à análise de desenhos infantis utilizando inteligência artificial e visão computacional.

O protótipo permite que o usuário envie um desenho e visualize o resultado da análise realizada pela API.

---

## 🔄 Como funciona

O funcionamento do aplicativo ocorre em algumas etapas:

```text
Usuário
   ↓
Seleciona um desenho
   ↓
Flutter envia a imagem
   ↓
API recebe a imagem
   ↓
Modelo YOLO realiza a análise
   ↓
Resultado retorna para o aplicativo
   ↓
Usuário visualiza o resultado
````

---

## 📱 Estrutura do aplicativo

A aplicação possui telas voltadas para:

* **Tela inicial** — apresenta o projeto e direciona o usuário para a análise;
* **Tela de envio** — permite selecionar e enviar um desenho;
* **Tela de resultado** — apresenta o resultado retornado pela API;
* **Tela sobre** — explica a proposta do NeuroSketch e o funcionamento da análise.

---

## 🚀 Como executar

### 1. Instale o Flutter

Certifique-se de que o Flutter esteja instalado e configurado no computador.

Depois, verifique a instalação:

```bash
flutter doctor
```

### 2. Clone o repositório

```bash
git clone https://github.com/AnaClaraRivas/neurosketch.git
```

Entre na pasta

### 3. Instale as dependências

```bash
flutter pub get
```

### 4. Configure a API

No arquivo responsável pela comunicação com a API (api_service.dart) , configure a URL do servidor.

Para executar a API localmente no computador, por exemplo:

```dart
static const String baseUrl = "http://127.0.0.1:8000";
```

Para acessar a API a partir de um celular conectado à mesma rede, utilize o endereço IP do computador.

### 5. Execute o aplicativo

```bash
flutter run
```

Para executar no navegador:

```bash
flutter run -d chrome
```

---

## 🔗 Comunicação com a API

O aplicativo realiza uma requisição `POST` para o endpoint:

```text
/analisar
```

A imagem é enviada utilizando `multipart/form-data`, através do campo:

```text
file
```

A API processa a imagem e retorna os dados da análise em formato JSON.

---
```

