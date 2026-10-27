export class HttpError extends Error{constructor(status,message){super(message);this.status=status;}}
export const asyncRoute=fn=>(q,s,n)=>Promise.resolve(fn(q,s,n)).catch(n);
export const ok=(res,data,status=200)=>res.status(status).json({ok:true,data});
