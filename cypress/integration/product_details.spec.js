describe('Jungle testing', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it("Click on first product", () => {
    cy.get(".products article").first().click();
    cy.get("article").should('have.class', 'product-detail').contains("The Scented Blade is an extremely").should('be.visible');

  });
});