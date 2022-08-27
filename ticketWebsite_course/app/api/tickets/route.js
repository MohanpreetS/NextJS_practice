import { NextResponse } from 'next/server'
import { cookies } from 'next/headers'
import { createRouteHandlerClient } from '@supabase/auth-helpers-nextjs'

export async function POST(request) {
  const ticket = await request.json()

  // get supabase instance
  const supabase = createRouteHandlerClient({ cookies })

  // get current user session
  const { data: { session } } = await supabase.auth.getSession()

  // insert the data
  
  return NextResponse.json({ data, error })
}