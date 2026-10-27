import jwt from 'jsonwebtoken';import {env} from '../config/env.js';import {HttpError} from '../utils/http.js';
export function auth(q,_s,n){const t=q.get('authorization')?.replace(/^Bearer\s+/i,'');if(!t)return n(new HttpError(401,'Authentication required'));try{q.user=jwt.verify(t,env.jwtSecret);n();}catch{n(new HttpError(401,'Invalid or expired session'));}}
export const roles=(...r)=>(q,_s,n)=>r.includes(q.user?.role)?n():n(new HttpError(403,'Insufficient permission'));
