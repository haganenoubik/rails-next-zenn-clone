import type { NextPage } from 'next'
import useSWR from 'swr'
import { fetcher } from '@/utils'

type HealthCheckResponse = {
  message: string
}

const Index: NextPage = () => {
  const url = 'http://localhost:3000/api/v1/health_check'
  const { data, error } = useSWR<HealthCheckResponse>(url, fetcher)

  if (error) return <div>エラーが発生しました</div>
  if (!data) return <div>Loading...</div>

  return (
    <>
      <div>Rails疎通チェック</div>
      <div>レスポンスメッセージ： {data.message}</div>
    </>
  )
}

export default Index
