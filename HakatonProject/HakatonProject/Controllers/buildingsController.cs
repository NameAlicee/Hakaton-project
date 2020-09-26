using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using HakatonProject.Models;

namespace HakatonProject.Controllers
{
    public class buildingsController : Controller
    {
        private Hakaton_projectEntities db = new Hakaton_projectEntities();

        // GET: buildings
        public ActionResult Index()
        {
            return View(db.buildings.ToList());
        }

        // GET: buildings/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            buildings buildings = db.buildings.Find(id);
            if (buildings == null)
            {
                return HttpNotFound();
            }
            return View(buildings);
        }

        // GET: buildings/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: buildings/Create
        // Чтобы защититься от атак чрезмерной передачи данных, включите определенные свойства, для которых следует установить привязку. Дополнительные 
        // сведения см. в статье https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID,Name,Address")] buildings buildings)
        {
            if (ModelState.IsValid)
            {
                db.buildings.Add(buildings);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(buildings);
        }

        // GET: buildings/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            buildings buildings = db.buildings.Find(id);
            if (buildings == null)
            {
                return HttpNotFound();
            }
            return View(buildings);
        }

        // POST: buildings/Edit/5
        // Чтобы защититься от атак чрезмерной передачи данных, включите определенные свойства, для которых следует установить привязку. Дополнительные 
        // сведения см. в статье https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,Name,Address")] buildings buildings)
        {
            if (ModelState.IsValid)
            {
                db.Entry(buildings).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(buildings);
        }

        // GET: buildings/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            buildings buildings = db.buildings.Find(id);
            if (buildings == null)
            {
                return HttpNotFound();
            }
            return View(buildings);
        }

        // POST: buildings/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            buildings buildings = db.buildings.Find(id);
            db.buildings.Remove(buildings);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
