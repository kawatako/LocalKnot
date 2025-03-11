// ブログ記事の編集画面で、アップロード済みの画像一覧の中の画像をクリックしたときに、その画像の URL を取得し、Trix エディターのカーソル位置に、その画像を埋め込むための HTML (<figure> タグと <img> タグ) を挿入する
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "trixEditor" ]

  insert(event) {
    event.preventDefault()
    const imageUrl = event.currentTarget.dataset.imageUrl
    if (this.hasTrixEditorTarget) {
      // Trix エディタに画像を挿入 (attachment として)
      this.trixEditorTarget.editor.insertHTML(`<figure data-trix-attachment='{"contentType":"image/*", "url":"${imageUrl}"}'><img src="${imageUrl}"></figure>`)
    }
  }
}