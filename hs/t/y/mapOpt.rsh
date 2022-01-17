'reach 0.1';

const MUI = Maybe(UInt);
export const main = Reach.App(() => {
  const A = Participant('A', { who: Address });
  init();
  A.only(() => {
    const i = 1;
    const who = declassify(interact.who);
  });
  A.publish(i, who);
  const M = new Map(UInt);
  M[A] = 0;
  commit();
  A.publish();
  const x = M[A];
  assert(x == MUI.Some(0));
  const y = M[A];
  assert(y == MUI.Some(0));
  const xs = fromSome(x, 15);
  const ys = fromSome(y, 15);
  assert(xs == ys);
  
  const wx = M[who];
  const wy = M[who];
  assert(wy == wx);
  const wxs = fromSome(wx, 15);
  const wys = fromSome(wy, 15);
  assert(wxs == wys);

  M[A] = 1;
  const z = M[A];
  assert(z == MUI.Some(1));
  if ( i < 10 ) {
    M[A] = 2;
  }
  const v = M[A];
  assert(v == MUI.Some(i < 10 ? 2 : 1));
  commit();
  A.only(() => {
    const [ xsa, ysa, va, xa, ya, za ] = [ xs, ys, v, x, y, z ];
  });
  A.publish(xsa, ysa, va, xa, ya, za);
  require(xsa == xs && ysa == ys && va == v && xa == x && ya == y && za == z);
  delete M[A];
  const u = M[A];
  assert(u == MUI.None());
  commit();
  exit();
});