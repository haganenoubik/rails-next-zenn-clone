require "rails_helper"

RSpec.describe Article, type: :model do
  describe "GET api/v1/current/articles" do
    subject { get(api_v1_current_articles_path, headers:) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }

    before { create_list(:article, 2, user: other_user) }

    context "ログインユーザーに紐づく articles レコードが存在する時" do
      before { create_list(:article, 3, user: current_user) }

      it "正常にレコードを取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res.length).to eq 3
        expect(res[0].keys).to eq ["id", "title", "content", "status", "created_at", "from_today", "user"]
        expect(res[0]["user"].keys).to eq ["name"]
        expect(response).to have_http_status(:ok)
      end
    end

    context "ログインユーザーに紐づく articles レコードが存在しない時" do
      it "空の配列が返る" do
        subject
        res = JSON.parse(response.body)
        expect(res).to eq []
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET api/v1/current/articles/:id" do
    subject { get(api_v1_current_article_path(id), headers:) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }

    context ":id がログインユーザーに紐づく articles レコードの id である時" do
      let(:current_user_article) { create(:article, user: current_user) }
      let(:id) { current_user_article.id }

      it "正常にレコードを取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res.keys).to eq ["id", "title", "content", "status", "created_at", "from_today", "user"]
        expect(res["user"].keys).to eq ["name"]
        expect(response).to have_http_status(:ok)
      end
    end

    context ":id がログインユーザーに紐づく articles レコードの id ではない時" do
      let(:other_user_article) { create(:article) }
      let(:id) { other_user_article.id }

      it "例外が発生する" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context "factoryのデフォルト設定に従った時" do
    subject { create(:article) }

    it "正常にレコードを新規作成できる" do
      expect { subject }.to change { Article.count }.by(1)
    end
  end

  describe "Validations" do
    subject { article.valid? }

    let(:article) { build(:article, title:, content:, status:, user:) }
    let(:title) { Faker::Lorem.sentence }
    let(:content) { Faker::Lorem.paragraph }
    let(:status) { :published }
    let(:user) { create(:user) }

    context "全ての値が正常な時" do
      it "検証が通る" do
        expect(subject).to be_truthy
      end
    end

    context "ステータスが公開済みかつ、タイトルが空の時" do
      let(:title) { "" }

      it "エラーメッセージが返る" do
        expect(subject).to be_falsy
        expect(article.errors.full_messages).to eq ["タイトルを入力してください"]
      end
    end

    context "ステータスが公開済みかつ、本文が空の時" do
      let(:content) { "" }

      it "エラーメッセージが返る" do
        expect(subject).to be_falsy
        expect(article.errors.full_messages).to eq ["本文を入力してください"]
      end
    end

    context "ステータスが未保存かつ、すでに同一ユーザーが未保存ステータスの記事を所有していた時" do
      let(:status) { :unsaved }
      before { create(:article, status: :unsaved, user:) }

      it "例外が発生する" do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end
