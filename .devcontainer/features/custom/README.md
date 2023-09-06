# プロジェクト用の devcontainer features について

プロジェクト専用の README ファイルです。

ここでは、プロジェクトに特化したプログラミング言語/フレームワーク/ライブラリなどを事前にインストールするための設定をここで管理します。
`.devcontainer/features/custom`配下にプロジェクト固有のパッケージなどを管理します。

## 利用用途

テンプレートリポジトリとして用意してる
`root`, `web`, `web-tw`, `web-mui`, `infra`, `app`

以外でパッケージ/ライブラリのインストールを設定します。

例えば、`.devcontainer/features/root` には git, awscli など、`.devcontainer/features/web` の場合は amplify, npm のパッケージをデフォルトでインストールするように設定しています。

#### .devcontainer/features/custom/devcontainer-feature.json について

- テンプレートで必須のツールとは別に、チームで使いたいツール(CLI や言語)を プロジェクト固有で devcontainer に導入する際に利用します。

- devcontainer 内にインストールしたい features は[Available Dev Container Features](https://containers.dev/features)を参照してください。

#### .devcontainer/features/custom/post-create-command-main.sh について

- Dev Container Features でサポートされてないパッケージ/ライブラリをインストールしたい場合に利用します。
- Dev Container でコンテナ作成後にインストールされるので、適宜活用してください。

#### .devcontainer/features/custom/post-create-command-test.sh について

- devcontainer 上で postCreateCommand で定義したパッケージ/ライブラリが正しくインストールされているかテストを実行します。
- 品質を担保するため、チームで採用したパッケージなどに対して [Testinfra](https://testinfra.readthedocs.io/en/latest/) を活用してください。

- Testinfra を使用すると、Python で単体テストを作成し、Salt、Ansible、Puppet、 Chef などの管理ツールによって構成されたサーバーの実際の状態をテストできます。

#### .devcontainer/features/custom/install.sh について

- Dev Container Features でサポートされてないパッケージ/ライブラリをインストールしたい場合に利用します。

#### .devcontainer/features/custom/README.md について

下記以降、プロジェクト固有としてドキュメントとなる README を記載してください。

---
