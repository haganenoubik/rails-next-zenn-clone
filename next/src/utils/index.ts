import axios, { AxiosResponse, AxiosError } from 'axios'

// fetcher関数は指定されたURLからデータを取得します
export const fetcher = (url: string) => 
  axios
    .get(url) // 指定されたURLにGETリクエストを送信します
    .then((res: AxiosResponse) => res.data) // レスポンスが成功した場合、レスポンスのデータを返します
    .catch((err: AxiosError) => {
      console.log(err.message) // エラーメッセージをコンソールに出力します
      throw err // エラーを再スローします（再度スローすることで、呼び出し元でエラーをキャッチできます）
    })
